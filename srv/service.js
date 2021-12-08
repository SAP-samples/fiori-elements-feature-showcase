const cds = require("@sap/cds");

module.exports = async (srv) => {

    const {RootEntities,ChildEntities1,ChildEntities2,ChildEntities3,GrandChildEntities,ChartDataEntities, Contacts, Countries,Criticality,Currencies,UnitOfMeasureCodeList} = srv.entities;

    srv.after(["READ"],RootEntities, async (response) => {
        //To avoid issues with cds watch when it is reloading
        if(!response) return;

        //Create Address Label of contact
        //The address label is a property which contains all address information of a contact in a single string
        //To avoid managing the properties itself and the string, the concatination is done
        //The concatination is only done, if the addressLabel is requested and the contact ID is available
        if(response.hasOwnProperty('contact') && response.contact.addressLabel === null) {
            //Requesting the 
            const contact =  await SELECT.one.from(Contacts,response.contact.ID, contact => {
                contact.ID, contact.building, contact.street, contact.postCode, contact.city, contact.country (country => {
                    country.name
                })
                });
            response.contact.addressLabel = `${contact.building}\n${contact.street}\n${contact.postCode} ${contact.city}\n${contact.country.name}`;
            await UPDATE(Contacts,response.contact.ID).with({addressLabel : response.contact.addressLabel}); //Update the persistence with the generated value
        }

        //Calculate Chart Criticality Values
        //Only calculate, if the chartEntities (source) is part of the request and is not empty (would be useless to calculate)
        if(response.hasOwnProperty('chartEntities') && response.chartEntities.length > 0) {
            //If the forecast or target Value is not given, they should be requested and when the request is empty they should be generated
            //Both value are needed to fill in the values needed for the criticality calculation
            if(!response.chartEntities[0].hasOwnProperty('forecastValue') || !response.chartEntities[0].hasOwnProperty('targetValue')) {
                //Requesting all chart entities and create a map, where the chart entity Id is key and an object containing target and forecast value is the value
                const chartEntities =  new Map((await SELECT.from(ChartDataEntities, item => {
                    item.ID, item.forecastValue, item.targetValue
                }).where({parent_ID : response.ID})).map(key => [key.ID, { forecastValue: key.forecastValue, targetValue: key.targetValue }]));
                //Calculating the forcast and target Value of each chart entity
                response.chartEntities.forEach(async e => {
                    e.forecastValue = (chartEntities.get(e.ID) != undefined) ? chartEntities.get(e.ID).forecastValue : e.integerValue + 10;
                    e.targetValue = (chartEntities.get(e.ID) != undefined) ? chartEntities.get(e.ID).targetValue : e.integerValue + 20;
                })
            }
            //Calculate the values important for the criticality calculation
            //This is done to avoid manageing all these value in the csv file
            response.chartEntities.forEach(e => {
                e.areaChartToleranceUpperBoundValue = e.integerValue + Math.round((e.integerValue / e.targetValue) *5 + 15);
                e.areaChartToleranceLowerBoundValue = e.integerValue - Math.round((e.integerValue / e.targetValue) *5 + 15);
                e.areaChartDeviationUpperBoundValue = e.forecastValue + Math.round((e.integerValue / e.forecastValue) *10 + 30);
                e.areaChartDeviationLowerBoundValue = e.forecastValue - Math.round((e.integerValue / e.forecastValue) *10 + 30);
            });
        }
    });

    //Filling of properties, when a new RootEntity is created
    srv.before('NEW',RootEntities, async (req) => {
        req.data.contact_ID = (await SELECT.one.from(Contacts, contact => {contact.ID})).ID; //Default Contact to prevent Error when creating address label
        //Generating chart entities, so the charts are not empty - the user has no option to fill in chart entity values in the UI
        req.data.chartEntities = [];
        for(let i = 1; i <= 10; i++) {
            req.data.chartEntities.push({
                ID : cds.utils.uuid(),
                parent_ID : req.data.ID,
                uom_code : 'EA',
                dimensions : i,
                integerValue : i+30,
                forecastValue : i*2+35,
                targetValue : i*1.6+36,
                criticality_code : i % 4,
                DraftAdministrativeData_DraftUUID : req.data.DraftAdministrativeData_DraftUUID
            });
        }
    })

    //=============================================================================================================
    //      Actions
    //=============================================================================================================

    srv.on("changeCriticality",RootEntities, async (req) => {
        //Req.data contains the parameter values of the action
        //Req.params contains IDs and Draft IDs of the entity
        const criticality_code = req.data.newCriticality, headerID = req.params[0].ID;
        //Update the current RootEntity with the new value for ciritcality_code and fieldWithCriticality  
        return UPDATE(RootEntities,headerID).with({criticality_code : criticality_code, fieldWithCriticality : determineFieldWithCriticalityValue(criticality_code)});
    });

    function determineFieldWithCriticalityValue(criticality_code) {
        let fieldWithCriticality = '';
        switch(criticality_code) {
            case 0:
                fieldWithCriticality = 'Neutral'
                break;
            case 1:
                fieldWithCriticality = 'Negative'
                break;
            case 2:
                fieldWithCriticality = 'Critical'
                break;
            case 3:
                fieldWithCriticality = 'Positive'
                break;
            case 5:
                fieldWithCriticality = 'New Item'
                break;
            default:
                fieldWithCriticality = 'Unknown criticality';
                break;
        }
        return fieldWithCriticality;
    }


    srv.on("changeProgress",RootEntities, async (req) => {
        const integerValue = req.data.newProgress, headerID = req.params[0].ID;
        return UPDATE(RootEntities,headerID).with({integerValue})
    });

    //Returns the input parameter as a message to the front end. The message will show up in a dialog.
    srv.on("unboundAction", async req => {
        return req.info(`INPUT: ${req.data.input}`);
    });

    //Returns a message toast at the bottom of the screen, indicating that the action was triggered.
    srv.on("criticalAction", async req => {
        return req.notify(`Critical action pressed`); //Search-Term: #MessageToast
    });

    //Reseting all entities to there default state
    srv.on("resetEntities", async req => { 
        //Delete current data
        await cleanUpDatabaseEntities();
        //Create new entities
        const countRootEntities = 4;
        const childEntity2IDs = await createChildEntities2(countRootEntities);
        const rootEntities = [];
        const imageUrls = ['sap-icon://lab','/media/crate.png','/media/bigBen.png','sap-icon://cart']
        const contacts = await SELECT.from(Contacts).columns('ID');
        const unitOfMeasures = await SELECT.from(UnitOfMeasureCodeList).columns('code');
        const currencies = await SELECT.from(Currencies).columns('code');
        const criticaityCodes = await SELECT.from(Criticality).columns('code');
        const countries = await SELECT.from(Countries).columns('code');
        for(let i = 0; i < countRootEntities; i++) {
            const date = new Date();
            let date2 = new Date(date.toISOString());
            date2.setMonth(date2.getMonth()+3);
            let uuid = cds.utils.uuid();
            rootEntities.push({
                ID: uuid,
                contact_ID: (i >= contacts.length) ? contacts[0].ID : contacts[i].ID,
                childEntity2_ID: childEntity2IDs[i],
                imageUrl: (i >= imageUrls.length) ? imageUrls[0] : imageUrls[i],
                uom_code: (i >= unitOfMeasures.length) ? unitOfMeasures[0].code : unitOfMeasures[i].code,
                isoCurrency_code: (i >= currencies.length) ? currencies[0].code : currencies[i].code,
                criticality_code: (i >= criticaityCodes.length) ? criticaityCodes[0].code : criticaityCodes[i].code,
                country_code: (i >= countries.length) ? countries[0].code : countries[i].code,
                //Calculating values, just to have values for the UI. The generation has no special logic behind it.
                stringProperty: (i===0) ? `Root entity ${i+1} and delete not possible` : (i===1) ? `Root entity ${i+1} and update not possible` : `Root entity ${i+1}`,
                deletePossible: (i===0) ? false : true,
                updateHidden: (i===1) ? true : false,
                dimensions: ((i+1)*2===6) ? i*2 : (i+1)*2, //manipulate values, that two entities have one dimension for demonstrating aggregation on ALP floorplan
                validFrom: date.toISOString().substring(0,11),
                validTo: date2.toISOString().substring(0,11),
                time: `${date.getHours()}:${date.getMinutes()}:${date.getSeconds()}`,
                timeStamp: date.toISOString(),
                fieldWithUoM: i*49+49,
                fieldWithPrice: i*100,
                fieldWithCriticality: determineFieldWithCriticalityValue((i === criticaityCodes.length) ? criticaityCodes[0] : criticaityCodes[i]),
                integerValue: 20+2*i,
                forecastValue: 20+2*i+(10*i),
                targetValue: 20+2*i+(10*(i+2)),
                starsValue: (Math.random()*40)/10, //Value has to be between 0 and 4
                //Fixed properties
                email: 'test.test@sap.com',
                telephone: '+49-6227-12383-2',
                fieldWithURL: 'https://www.sap.com;',
                fieldWithURLtext: 'SAP',
                description: 'Lorem ipsum dolor sit amet, \n consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
                //Compositions to many:
                childEntities1: await createChildEntities1(3,uuid),
                childEntities3: await createChildEntities3(2,uuid),
                chartEntities: await createChartEntities(10,uuid),
            });
        }
        await cds.tx(req).run(INSERT.into(RootEntities).entries(rootEntities));
        return req.notify(`All entitiy data has been reseted!`);
    });

    async function createChildEntities2(countRootEntities) {
        const childEntities2IDs = [];
        for(let i = 0; i <= countRootEntities; i++) {
            childEntities2IDs.push(cds.utils.uuid());
        }
        const childEntities2 = [];
        for(let i = 0; i <= countRootEntities; i++) {
            childEntities2.push({
                ID: childEntities2IDs[i],
                stringProperty: 'fieldValue',
                integerProperty: i*2+20,
                decimalProperty: 30+i/10,
                country_code: 'FR',
            });
        }
        await INSERT.into(ChildEntities2).entries(childEntities2);
        //Returns the IDs, so they can be assigned to the childEntity2_ID property of the RootEntities
        return childEntities2IDs;
    }

    async function createChildEntities1(amount, parent_ID) {
        let childEntities1 = [];
        for(let i = 0; i < amount; i++) {
            let grandChildEntities = [];
            for(let i = 1; i <= amount; i++) {
                grandChildEntities.push({
                    field: `grandchild ${i}`
                });
            }

            childEntities1.push({
                ID: cds.utils.uuid(),
                parent_ID: parent_ID,
                //Calculating values, just to have values for the UI. The generation has no special logic behind it.
                fieldWithPerCent: (Math.random()+0.1)*100,
                booleanProperty: (Math.random() > 0.5) ? true : false,
                criticalityValue_code: (i%2===0) ? 1 : (i%3===0) ? 2 : (i%5===0) ? 3 : 0,
                field: `child entity ${i}`,
                grandChildren: grandChildEntities,
            });
        }
        return childEntities1;
    }

    async function createChildEntities3(amount, parent_ID) {
        let childEntities3 = [];
        for(let i = 0; i < amount; i++) {
            childEntities3.push({
                ID: cds.utils.uuid(),
                parent_ID: parent_ID,
                field: `child entity ${i}`,
            });
        }
        return childEntities3;
    }

    async function createChartEntities(amount, parent_ID) {
        let chartEntities = [];
            for(let i = 1; i <= amount; i++) {
                chartEntities.push({
                    ID : cds.utils.uuid(),
                    parent_ID : parent_ID,
                    uom_code : 'EA',
                    dimensions : i,
                    integerValue : i+30,
                    forecastValue : i*2+35,
                    targetValue : i*1.6+36,
                    criticality_code : i % 4
                });
            }
        console.log("Created Chart Data Entities!");
        return chartEntities;
    }

    async function cleanUpDatabaseEntities() {
        await DELETE.from(RootEntities);
        await DELETE.from(ChildEntities1);
        await DELETE.from(ChildEntities2);
        await DELETE.from(ChildEntities3);
        await DELETE.from(ChartDataEntities);
        await DELETE.from(GrandChildEntities);
    }
};
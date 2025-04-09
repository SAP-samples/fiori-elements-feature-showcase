using { sap.fe.featureShowcase as schema } from '../../db/schema';

//
// annotations for value helps
// Search-Term: #ValueHelps
//

annotate schema.RootEntities with{
    uom         @Common.ValueListWithFixedValues; //Instead of dialog box, the value help is a dropdown
    criticality_code @(Common : {
        ValueListWithFixedValues: true,
        // Search-Term: #RadioButtons | Render Value help with radio buttons
        ValueListWithFixedValues.@Common.ValueListShowValuesImmediately,
        ValueList       : {
            Label          : '{i18n>criticality}',
            CollectionPath : 'Criticality',
            Parameters     : [
                {
                    $Type               : 'Common.ValueListParameterInOut',
                    ValueListProperty   : 'code',
                    LocalDataProperty   : criticality_code
                },
            ]
        }
    });

    //To have a Value help when editing and to show the name instead of the UUID
    contact @(Common : {
        Text            : contact.name,
        TextArrangement : #TextOnly,
        ValueList       : {
            Label          : '{i18n>customer}', //Title of the value help dialog
            CollectionPath : 'Contacts', //Entities of the value help. Refers to an entity name from the CAP service
            Parameters     : [
                {
                    $Type               : 'Common.ValueListParameterInOut',
                    ValueListProperty   : 'ID', //Binding between ID and contact_ID, that everything works
                    LocalDataProperty   : contact_ID
                },
                {
                    $Type               : 'Common.ValueListParameterDisplayOnly', //Displays additional information from the entity set of the value help 
                    ValueListProperty   : 'country_code',
                },
                {
                    $Type               : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty   : 'city',
                }
                
            ]
        }
    });
    association2one @(Common : {
        ValueListWithFixedValues: true,
        ValueList       : {
            Label          : '{i18n>ChildEntity2}',
            CollectionPath : 'ChildEntities2',
            Parameters     : [
                {
                    $Type               : 'Common.ValueListParameterInOut',
                    ValueListProperty   : 'ID',
                    LocalDataProperty   : association2one_ID
                },
                {
                    $Type               : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty   : 'stringProperty',
                },
                {
                    $Type               : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty   : 'integerProperty',
                },
                {
                    $Type               : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty   : 'decimalProperty',
                },
                {
                    $Type               : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty   : 'country_code',
                }
                
            ]
        }
    });
    //Search-Term: #DependentFilter
    region @(Common : {
        Text            : region.name,
        TextArrangement : #TextFirst,
        ValueListWithFixedValues: true,
        ValueList       : {
            Label          : '{i18n>Region}',
            CollectionPath : 'Regions',
            Parameters     : [
                {
                    $Type               : 'Common.ValueListParameterInOut',
                    ValueListProperty   : 'code',
                    LocalDataProperty   : region_code
                },
                {
                    $Type               : 'Common.ValueListParameterOut',
                    ValueListProperty   : 'name',
                    LocalDataProperty   : region.name,
                },
                //To only show the connected values
                {
                    $Type               : 'Common.ValueListParameterFilterOnly',
                    ValueListProperty   : 'country_code',
                },
                {
                    $Type               : 'Common.ValueListParameterIn', //Input parameter used for filtering
                    LocalDataProperty   : country_code,
                    ValueListProperty   : 'country_code',
                },
                
            ]
        }
    });
};

annotate schema.AssignedRegions with {
    //Search-Term: #MultiValueWithDependentFilter
    region @(Common : {
        Text            : region.name,
        TextArrangement : #TextFirst,
        ValueListWithFixedValues: true,
        ValueList       : {
            Label          : '{i18n>Region}',
            CollectionPath : 'Regions',
            Parameters     : [
                {
                    $Type               : 'Common.ValueListParameterInOut',
                    ValueListProperty   : 'code',
                    LocalDataProperty   : region_code
                },
                {
                    $Type               : 'Common.ValueListParameterIn', //Input parameter used for filtering
                    LocalDataProperty   : root.country_code,
                    ValueListProperty   : 'country_code',
                },
                
            ]
        }
    });
}
using service1                      as service          from '../../srv/service';
using service1.ChartDataEntities    as chartEntities    from './layouts_ChartDataEntities';
using service1.ChildEntities1       as childEntities1   from './layouts_ChildEntities1';
using service1.ChildEntities2       as childEntity2     from './layouts_ChildEntities2';
using service1.ChildEntities3       as childEntities3   from './layouts_ChildEntities3';
using service1.Contacts             as contact          from './layouts_contacts';

/**
    UI.Identification (Actions on Object Page) & Semantic Key
 */
annotate service.RootEntities with @(
    //Search-Term: #SemanticKey
    Common.SemanticKey  : [stringProperty],                 //field in bold, editing status displayed, when possible and it effects navigation 
    UI.Identification   : [
        {
            //Search-Term: #OPHeaderAction
            $Type                       : 'UI.DataFieldForAction',  //Action in the RootEntities of the object page next to the edit button
            Action                      : 'service1.changeCriticality',
            Label                       : '{i18n>changeCriticality}',
            Criticality                 : criticality_code,         //Only 0,1,3 supported
            CriticalityRepresentation   : #WithIcon,                //Has no effect
        },
        {
            //Search-Term: #DeterminingAction
            $Type                       : 'UI.DataFieldForAction',
            Action                      : 'service1.changeCriticality',
            Label                       : '{i18n>changeCriticality}',
            Determining                 : true,                     //The Action is in the footer of the object page
            Criticality                 : criticality_code,         //Only 0,1,3 supported
        },
    ],
    
    
);

/**
    UI.LineItem
 */
annotate service.RootEntities with @(
    UI.LineItem : {
        $value : [
            {
                //Search-Term: #Image
                $Type               : 'UI.DataField',
                Value               : imageUrl,
                ![@UI.Importance]   : #High,
            },
            {
                $Type               : 'UI.DataField',
                Value               : stringProperty,
                ![@UI.Importance]   : #High,
            },
            {
                $Type               : 'UI.DataField',
                Value               : fieldWithPrice,
                ![@UI.Importance]   : #High,
            },
            {
                //Search-Term: #ToolTip
                $Type               : 'UI.DataFieldForAnnotation',
                Target              : '@UI.DataPoint#fieldWithTooltip',
                Label               : '{i18n>fieldWithToolTip}',
            },
            {
                $Type               : 'UI.DataField',
                Value               : fieldWithUoM,
                ![@UI.Importance]   : #Low,
            },
            {
                $Type               : 'UI.DataField',
                Value               : fieldWithCriticality,
                Criticality         : criticality_code,     //Supported values 0,1,2,3,5
                CriticalityRepresentation   : #WithIcon,
                ![@UI.Importance]   : #Low,
            },
            {
                //Search-Term: #ProgressIndicator
                $Type               : 'UI.DataFieldForAnnotation', //Added progress indicator to table
                Label               : '{i18n>progressIndicator}',
                Target              : '@UI.DataPoint#progressIndicator',
                ![@UI.Importance]   : #Low,
            },
            {
                //Search-Term: #RatingIndicator
                $Type               : 'UI.DataFieldForAnnotation', //Added rating indicator to table
                Label               : '{i18n>ratingIndicator}',
                Target              : '@UI.DataPoint#ratingIndicator',
                ![@UI.Importance]   : #Low,
            },
            {
                //Search-Term: #MicroChart
                $Type               : 'UI.DataFieldForAnnotation',
                Label               : '{i18n>bulletChart}',
                Target              : '@UI.Chart#bulletChart',
                ![@UI.Importance]   : #High,
            },
            {
                //Search-Term: #QuickView
                $Type               : 'UI.DataField',
                Value               : childEntity2_ID,
                Label               : '{i18n>ChildEntity2}',
                ![@UI.Importance]   : #High,
            },
            {
                //Displaying field Group as Line Item - Adding multiple fields as one column
                //Search-Term: #MultiFieldsCol
                $Type               : 'UI.DataFieldForAnnotation',
                Target              : '@UI.FieldGroup#AdminData', 
                Label               : '{i18n>adminData}',
                ![@UI.Importance]   : #High,
            },
            {
                //Search-Term: #MicroChart
                $Type               : 'UI.DataFieldForAnnotation',
                Target              : '@UI.Chart#radialChart',
                Label               : '{i18n>radialChart}',
            },
            {
                //Contact Quick View
                //Search-Term: #Contact
                $Type               : 'UI.DataFieldForAnnotation',
                Target              : 'contact/@Communication.Contact',
                Label               : '{i18n>contactQuickView}'
            },
            {
                //Action button in the table toolbar
                $Type               : 'UI.DataFieldForAction',
                Action              : 'service1.changeCriticality', //Reference to the action of the CAP service
                Label               : '{i18n>changeCriticality}',
            },
            {
                //Action as a column of the table
                //Icons only supported for inline actions / intend based navigation
                $Type               : 'UI.DataFieldForAction',
                Action              : 'service1.changeProgress',
                Label               : '{i18n>changeProgess}',
                IconUrl             : 'sap-icon://command-line-interfaces',
                Inline              : true,
            },
            {
                //Search-Term: #NavAction
                $Type               : 'UI.DataFieldForIntentBasedNavigation',
                Label               : '{i18n>inboundNavigation}',
                SemanticObject      : 'FeatureShowcaseChildEntity2', //Target entity
                Action              : 'manage', //Specifies the app of the target entity
                RequiresContext     : true, //Wheather a row has to be selected or not
                Inline              : true, //Part of the table, when true
                IconUrl             : 'sap-icon://cart',//Icons only supported for inline actions / intend based navigation
                //Criticality is ignored, when using icons
                Mapping : [
                    {
                        $Type                   : 'Common.SemanticObjectMappingType',
                        LocalProperty           : integerValue, //it is a dummy mapping without sense
                        SemanticObjectProperty  : 'integerProperty',
                    },
                ],
                ![@UI.Importance]   : #High,
            },
            {
                $Type               : 'UI.DataFieldForAction',
                Action              : 'service1.EntityContainer/unboundAction', //Unbound actions need to be referenced through the entity container (Action import)
                Label               : '{i18n>unboundAction}',
            },
            {
                $Type               : 'UI.DataFieldForAction',
                Action              : 'service1.EntityContainer/criticalAction', //Unbound actions need to be referenced through the entity container (Action import)
                Label               : '{i18n>criticalAction}',
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action : 'service1.resetEntities(service1.RootEntities)', //Static action
                Label : '{i18n>resetEntities}',
            },
            {
                $Type               : 'UI.DataFieldWithUrl',
                Url                 : fieldWithURL, //Target, when pressing the text
                Value               : fieldWithURLtext, //Visible text
                Label               : '{i18n>dataFieldWithURL}',
                ![@UI.Importance]   : #Medium,
            },
        ],
        //Search-Term: #LineItemHighlight
        ![@UI.Criticality] : criticality_code, // Annotation, so that the row has a criticality
    },
    /**
        Used in Selection Presentation Variant
     */
    UI.LineItem #simplified : [
        {
            $Type                   : 'UI.DataField',
            Value                   : stringProperty,
            ![@UI.Importance]       : #High,
        },
        {
            $Type                   : 'UI.DataField',
            Value                   : fieldWithPrice,
            ![@UI.Importance]       : #High,
        },
        {
            $Type                   : 'UI.DataField',
            Value                   : fieldWithUoM,
            ![@UI.Importance]       : #High,
        },
        {
            $Type                   : 'UI.DataField',
            Value                   : fieldWithCriticality,
            Criticality             : criticality_code,
            ![@UI.Importance]       : #High,
        },
    ],
);

/**
    UI.FieldGroup
 */
annotate service.RootEntities with @(
    UI.FieldGroup #AdminData            : {
        Data  : [
            {Value : createdAt},
            {Value : createdBy},
            {Value : modifiedAt},
            {Value : modifiedBy},
        ]
    },
    UI.FieldGroup #Section              : {
        Data  : [
            {
                //Search-Term: #ConnectedFields
                //Connected fields only possible in field groups on object pages
                $Type   : 'UI.DataFieldForAnnotation',
                Target  : '@UI.ConnectedFields#ConnectedDates',
            },
            {   Value   : description},
            {   Value   : description_customGrowing},
            {
                //Search-Term: #NavAction
                $Type   : 'UI.DataFieldForIntentBasedNavigation',
                Label   : '{i18n>inboundNavigation}',
                SemanticObject  : 'FeatureShowcaseChildEntity2', //Target entity
                Action  : 'manage',             //Specifies the app of the target entity
                RequiresContext : true,         //If a row has to be selected or not
                IconUrl : 'sap-icon://cart',    //Icons only supported for inline actions / intend based navigation
                //Criticality is ignored, when using icons
                Mapping : [
                    {
                         //Dummy mapping, for demonstration purposes only
                        $Type                   : 'Common.SemanticObjectMappingType',
                        LocalProperty           : integerValue,
                        SemanticObjectProperty  : 'integerProperty',
                    },
                ],
                ![@UI.Importance] : #High,
            },
            {
                //Action for the field group. Visible in the upper right corner of the section
                $Type   : 'UI.DataFieldForAction',
                Action  : 'service1.EntityContainer/unboundAction',
                Label   : '{i18n>formActionEmphasized}',
                ![@UI.Emphasized] : true, //Button is highlighted
            },
            {
                //Action for the field group. Visible in the upper right corner of the form
                $Type   : 'UI.DataFieldForAction',
                Action  : 'service1.changeProgress',
                Label   : '{i18n>formAction}',
                Inline  : true, //Action in the Form toolbar instead of the section toolbar
            },
            {
		    $Type             : 'UI.DataField',
            Label			  : '{i18n>MultiInputField}',
            Value             : childEntities1.field,
        },
        ]
    },

    /**
        Search-Term: #Form
     */
    UI.FieldGroup #ShowWhenInEdit       : {
        Data : [
            {Value : stringProperty},
            {Value : fieldWithCriticality},
            {Value : fieldWithUoM},
            {Value : fieldWithPrice},
            {Value : criticality_code},
            {Value : contact_ID},
            {Value : childEntity2_ID},
        ]
    },
    UI.FieldGroup #chartData            : {
        Data : [
            {Value : integerValue},
            {Value : targetValue},
            {Value : forecastValue},
            {Value : dimensions},
        ]
    },
    UI.FieldGroup #advancedChartData    : {
        Data : [
            {Value : sumIntegerValue},
            {Value : sumTargetValue},
        ]
    },
    /**
        Search-Term: #HeaderFieldGroup
     */
    UI.FieldGroup #HeaderData           : {
        Data : [
            {Value : stringProperty},
            {Value : fieldWithCriticality, Criticality : criticality_code},
            {Value : fieldWithUoM},
            {Value : childEntity2_ID}, //Displaying a quick view facet
            {
                //Displaying a contect card
                $Type   : 'UI.DataFieldForAnnotation',
                Target  : 'contact/@Communication.Contact',
                Label   : '{i18n>contact}',
            },
        ]
    },
    UI.FieldGroup #location             : {
        Data : [
            {Value : country_code},
            {Value : region_code},
        ]
    },
    UI.FieldGroup #communication        : {
        Data : [
            {Value : email},
            {Value : telephone}
        ]
    },
    /**
        Displaying Date, Time or TimeStamp values is done by SAP Fiori elements out of the Box
     */
    UI.FieldGroup #timeAndDate          : {
        Data : [
            {Value : validTo},
            {Value : time},
            {Value : timeStamp}
        ]
    },
    /**
        Search-Term: #PlainText
     */
    UI.FieldGroup #plainText            : {
        Data : [
            {Value : description}
        ]
    },
);

/**
    UI.ConnectedFields
    Search-Term: #ConnectedFields
 */
annotate service.RootEntities with @(
    //Connected Fields only possible for sections on object pages
    //Wont render in tables and not possible in RootEntities sections
    UI.ConnectedFields #ConnectedDates : {
        Label       : '{i18n>connectedField}',
        Template    : '{integerValue} / {targetValue}',
        Data        : {
            integerValue    : {
                $Type : 'UI.DataField', //Without $Type, it wont work
                Value : integerValue,
            },
            targetValue     : {
                $Type : 'UI.DataField',
                Value : targetValue,
            },
        },
    },
);

/**
    UI.HeaderInfo
    Search-Term: #HeaderInfo
 */
annotate service.RootEntities with @(
    UI.HeaderInfo :{
        TypeName        : '{i18n>RootEntities}',
        TypeNamePlural  : '{i18n>RootEntities.typeNamePlural}',
        Title           : {
            $Type : 'UI.DataField',
            Value : stringProperty,
        },
        Description     : {
            $Type : 'UI.DataField',
            Value : '{i18n>RootEntities}',
        },
        ImageUrl        : imageUrl,
        TypeImageUrl    : 'sap-icon://sales-order',
        Initials : 'RE', //Up to two latin letters are displayed
    },
);

/**
    UI.HeaderFacets
    Search-Term: #HeaderFacets
 */
annotate service.RootEntities with @(
    UI.HeaderFacets : [
        {
            $Type   : 'UI.ReferenceFacet',
            Target  : '@UI.DataPoint#fieldWithPrice',
        },
        {
            $Type   : 'UI.CollectionFacet',
            Facets  : [
                {
                    //Search-Term: #HeaderFieldGroup
                    $Type   : 'UI.ReferenceFacet',
                    Target  : '@UI.FieldGroup#HeaderData',
                    Label   : '{i18n>generalData}',
                },
                {
                    $Type   : 'UI.ReferenceFacet',
                    Target  : '@UI.Chart#bulletChart',
                },
            ],
        },
        {
            $Type   : 'UI.CollectionFacet',
            ID      : 'CollectionFacet1',
            Facets  : [
                {
                    //Search-Term: #DataPoint
                    $Type   : 'UI.ReferenceFacet',
                    Target  : '@UI.DataPoint#ratingIndicator',
                },
                {
                    //Search-Term: #DataPoint
                    $Type   : 'UI.ReferenceFacet',
                    Target  : '@UI.DataPoint#progressIndicator',
                },
                {
                    //Search-Term: #AddressFacet
                    $Type   : 'UI.ReferenceFacet',
                    Target  : 'contact/@Communication.Address',
                    Label   : '{i18n>address}'
                },
            ],
        },
        {
            $Type   : 'UI.CollectionFacet',
            ID      : 'CollectionFacet2',
            Facets  : [
                {
                    $Type   : 'UI.ReferenceFacet',
                    Target  : 'chartEntities/@UI.Chart#areaChart',
                },
                {
                    $Type   : 'UI.ReferenceFacet',
                    Target  : '@UI.Chart#radialChart',
                },
            ],
        },
        {
            //Search-Term: #PlainText
            $Type   : 'UI.ReferenceFacet',
            Target  : '@UI.FieldGroup#plainText',
            Label   : '{i18n>plainText}'
        },
        {
            //Search-Term: #OPMicroChart
            $Type   : 'UI.ReferenceFacet',
            Target  : 'chartEntities/@UI.Chart#lineChart',
        },
        {
            //Search-Term: #OPMicroChart
            $Type   : 'UI.ReferenceFacet',
            Target  : 'chartEntities/@UI.Chart#columnChart',
        },
        {
            //Search-Term: #OPMicroChart
            $Type   : 'UI.ReferenceFacet',
            Target  : '@UI.Chart#harveyChart',
        },
        {
            //Search-Term: #OPMicroChart
            $Type   : 'UI.ReferenceFacet',
            Target  : 'chartEntities/@UI.Chart#stackedBarChart',
        },
        {
            //Search-Term: #OPMicroChart
            $Type   : 'UI.ReferenceFacet',
            Target  : 'chartEntities/@UI.Chart#comparisonChart',
        },
    ],
);

/**
    UI.Facets
    Search-Term: #OPContentArea
 */
annotate service.RootEntities with @(
    UI.Facets : [
        {
            $Type   : 'UI.CollectionFacet',
            ID      : 'collectionFacetSection',
            Label   : '{i18n>collectionSection}',
            Facets  : [
                {
                    $Type   : 'UI.ReferenceFacet',
                    Target  : '@UI.FieldGroup#Section',
                    ID      : 'SubSectionID',
                    Label   : '{i18n>subSection}',
                },
                {
                    $Type   : 'UI.ReferenceFacet',
                    Target  : '@UI.FieldGroup#location',
                    Label   : '{i18n>locationSubSection}'
                },
                {
                    $Type   : 'UI.ReferenceFacet',
                    Target  : '@UI.FieldGroup#communication',
                    Label   : '{i18n>communication}',
                },
                {
                    $Type   : 'UI.ReferenceFacet',
                    Target  : '@UI.FieldGroup#timeAndDate',
                    Label   : '{i18n>timeAndDate}',
                },
            ],
        },
        {
            //Search-Terms: #Form, #HidingContent
            $Type           : 'UI.ReferenceFacet',
            Target          : '@UI.FieldGroup#ShowWhenInEdit',
            Label           : '{i18n>showWhenInEdit}',
            ![@UI.Hidden]   : IsActiveEntity,
        },
        {
            $Type   : 'UI.CollectionFacet',
            Label   : '{i18n>chartDataCollection}',
            ID      : 'chartDataCollection', //Used for Header Facet Navigation
            Facets : [
                {
                    $Type   : 'UI.ReferenceFacet',
                    Target  : '@UI.FieldGroup#chartData',
                    Label   : '{i18n>chartData}',
                },
                {
                    $Type   : 'UI.ReferenceFacet',
                    Target  : '@UI.FieldGroup#advancedChartData',
                    ID      : 'advancedChartData', //Search-Term: #InboundNav //Used for RootEntities facet navigation
                    Label   : '{i18n>advancedChartData}',
                    ![@UI.PartOfPreview] : false //Hides the section beneath a Show More Button
                },
            ],
        },
        {
            $Type   : 'UI.ReferenceFacet',
            Target  : 'childEntities1/@UI.PresentationVariant',
            ID      : 'childEntities1Section',
            Label   : '{i18n>childEntities1}',
        },
        
        {
            $Type   : 'UI.ReferenceFacet',
            Target  : 'childEntity2/@UI.FieldGroup#data',
            Label   : '{i18n>ChildEntity2}',
        },
        {
            $Type   : 'UI.ReferenceFacet',
            Target  : 'childEntities3/@UI.LineItem',
            Label   : '{i18n>childEntities3}',
        },
        {
            //Search-Term: #ChartSection
            $Type   : 'UI.ReferenceFacet',
            Target  : 'chartEntities/@UI.Chart',
            Label   : '{i18n>chart}'
        },
        /*{
            $Type   : 'UI.ReferenceFacet',
            Label   : '{i18n>AdminData}',
            Target  : '@UI.FieldGroup#AdminData',
        },*/
    ],
);

/**
    UI.PresentationVariant
    Search-Term: #DefaultSort
 */
annotate service.RootEntities with @(
    UI.PresentationVariant : {
        SortOrder       : [ //Default sort order
            {
                Property    : stringProperty,
                Descending  : false,
            },
        ],
        Visualizations  : ['@UI.LineItem'],
    },
);

/**
    UI.FilterFacets
    Search-Term: #FilterGrouping
 */
annotate service.RootEntities with @(
    //Custom groups, when selecting filter fields
    UI.FilterFacets : [
        {
            Target  : '@UI.FieldGroup#chartData',
            Label   : '{i18n>chartData}',
        },
        {
            Target  : '@UI.FieldGroup#location',
            Label   : '{i18n>location}',
        },
    ],
);

/**
    UI.SelectionFields
    Search-Term: #VisibleFilters
 */
annotate service.RootEntities with @(
    //Shown filters for the given fields after opening the application
    UI.SelectionFields : [
        stringProperty,
        fieldWithPrice,
        criticality_code,
    ],
);

/**
    UI.SelectionVariant
    Search-Terms: #multipleViews, #SVariant
 */
annotate service.RootEntities with @(
    UI.SelectionVariant #variant1 : {
        Text            : '{i18n>SVariant1}',
        SelectOptions   : [ //Filtering of entity sets
            {
                PropertyName    : criticality_code,
                Ranges          : [
                    {
                        Sign    : #I,   //Include
                        High    : 2,
                        Option  : #BT,  //Betweeen
                        Low     : 0,
                    },
                ],
            },
        ],
    },
    UI.SelectionVariant #variant2 : {
        Text            : '{i18n>SVariant2}',
        SelectOptions   : [
            {
                PropertyName    : criticality_code,
                Ranges          : [
                    {
                        Sign    : #I,
                        Option  : #EQ, //Equals
                        Low     : 3,
                    },
                ],
            },
        ],
    },
);

/**
    UI.SelectionPresentationVariant
    Search-Terms: #multipleViews, #SPVariant
 */
annotate service.RootEntities with @(
    UI.SelectionPresentationVariant #SelectionPresentationVariant : {
        Text                : '{i18n>SelectionPresentationVariant}',
        SelectionVariant    : { //Filtering of entities
            SelectOptions   : [
                {
                    PropertyName    : criticality_code,
                    Ranges          : [
                        {
                            Sign    : #I,
                            Option  : #GT,
                            Low     : 0,
                        },
                    ],
                },
            ],
        },
        PresentationVariant : { //Sorting of the entities
            SortOrder       : [
                {
                    Property        : fieldWithPrice,
                    Descending      : false,
                },
            ],
            //Add Visualizations property can contain different line items then the default one
            Visualizations  : ['@UI.LineItem#simplified'],
        },
    },
);

/**
    UI.DataPoint
    Search-Term: #DataPoint
 */
annotate service.RootEntities with @(
    UI.DataPoint #progressIndicator : {
        //Search-Term: #ProgressIndicator
        Value           : integerValue,
        TargetValue     : 100,
        Visualization   : #Progress,
        Title           : '{i18n>progressIndicator}',
        //Criticality   : criticality, //> optional criticality
    },
    UI.DataPoint #ratingIndicator : {
        //Search-Term: #RatingIndicator
        Value           : starsValue, //Amount of stars, which are filled. Values between x.25 and x.74 are displaced as a half star.
        TargetValue     : 4, //Max amount of stars
        Visualization   : #Rating,
        Title           : '{i18n>ratingIndicator}',
        ![@Common.QuickInfo] : 'Tooltip via Common.QuickInfo',
    },
    UI.DataPoint #bulletChart : {
        //Search-Terms: #MicroChart, #microChartBullet
        Value           : integerValue,           //horizontal bar in relation to the goal line
        TargetValue     : targetValue,      //visual goal line in the UI
        ForecastValue   : forecastValue,  //horizontal bar behind the value bar with, slightly larger with higher transparency
        Criticality     : criticality_code, //> optional criticality
        MinimumValue    : 0,               //Minimal value, needed for output rendering
    },
    UI.DataPoint #radialChart : { 
        //Search-Terms: #MicroChart, #microChartRadial
        Value           : integerValue,
        TargetValue     : targetValue,      //The relation between the value and the target value will be displayed as a percentage
        Criticality     : criticality_code, //> optional criticality
    },
    UI.DataPoint #harveyChart : {
        //Search-Term: #microChartHarvey
        Value           : fieldWithPrice,
        MaximumValue    : fieldWithUoM, //MaximumValue needs to be of type Decimal
        Criticality     : criticality_code
    },
    UI.DataPoint #fieldWithPrice : {
        //Search-Term: #KeyValue
        Value           : fieldWithPrice,
        Title           : '{i18n>fieldWithPrice}',
    },
    UI.DataPoint #fieldWithTooltip : {
        //Search-Term: #ToolTip
        Value           : dimensions,
        ![@Common.QuickInfo] : '{i18n>Tooltip}', //Can also be a dynamic property path
    },
);

/**
    UI.Chart
 */
annotate service.RootEntities with @(
    UI.Chart #bulletChart : {
        //Search-Terms: #MicroChart, #microChartBullet
        Title       : '{i18n>bulletChart}',
        Description : '{i18n>ThisIsAMicroChart}',
        ChartType   : #Bullet,
        Dimensions  : [dimensions],
        Measures    : [integerValue],
        MeasureAttributes : [
            {
                $Type       : 'UI.ChartMeasureAttributeType',
                Measure     : integerValue,
                Role        : #Axis1,
                DataPoint   : '@UI.DataPoint#bulletChart',
            },
        ],
    },
    UI.Chart #radialChart : {
        //Search-Terms: #MicroChart, #microChartRadial
        Title       : '{i18n>radialChart}',
        Description : '{i18n>ThisIsAMicroChart}',
        ChartType   : #Donut,
        Measures    : [integerValue],
        MeasureAttributes : [
            {
                $Type       : 'UI.ChartMeasureAttributeType',
                Measure     : integerValue,
                Role        : #Axis1,
                DataPoint   : '@UI.DataPoint#radialChart',
            },
        ],
    },
    UI.Chart #harveyChart : {
        //Search-Term: #microChartHarvey
        Title       : '{i18n>harveyChart}',
        Description : '{i18n>ThisIsAMicroChart}',
        ChartType   : #Pie,
        Measures    : [fieldWithPrice],
        MeasureAttributes : [
            {
                $Type       : 'UI.ChartMeasureAttributeType',
                Measure     : fieldWithPrice,
                Role        : #Axis1,
                DataPoint   : '@UI.DataPoint#harveyChart',
            }
        ]
    },
);
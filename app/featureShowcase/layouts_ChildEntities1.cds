using service1 as service from '../../srv/service';
using service1.GrandChildEntities as grandChildren from './layouts_GrandChildEntities';

/**
    UI.LineItem
 */
annotate service.ChildEntities1 with @(
    UI.LineItem : [
        {
            $Type       : 'UI.DataField',
            Value       : field,
        },
        {
            $Type       : 'UI.DataField',
            Value       : fieldWithPerCent,
        },
        {
            $Type       : 'UI.DataField',
            Value       : booleanProperty,
            Criticality : criticalityValue_code,
        },
    ],
);

/**
    UI.HeaderInfo
 */
annotate service.ChildEntities1 with @(
    UI.HeaderInfo : {
        TypeName        : '{i18n>childEntities1}',
        TypeNamePlural  : '{i18n>childEntities1.typeNamePlural}', //Search-Term: #OPTableTitle
        Title           : {
            Value : '{i18n>childEntities1}',
        },
        Description     : {
            //Search-Term: #ODataConcat
            Value : {$edmJson: {
                $Apply : [
                    'Using odata.concat - Field: ',
                    {$Path: 'field'},
                ],
                $Function : 'odata.concat'
            }},
        },
        ImageUrl        : '',
        TypeImageUrl    : 'sap-icon://blank-tag',
    },
);

/**
    UI.HeaderFacets
 */
annotate service.ChildEntities1 with @(
    UI.HeaderFacets : [
        {
            $Type   : 'UI.ReferenceFacet',
            Target  : '@UI.DataPoint#fieldWithPercent',
            ID      : 'FacetWithPercent'
        },
    ],
);

/**
    UI.Facets
 */
annotate service.ChildEntities1 with @(
    UI.Facets : [
        {
            $Type   : 'UI.ReferenceFacet',
            Target  : 'grandChildren/@UI.LineItem',
            Label   : '{i18n>grandChildren}'
        },
    ],
);

/**
    UI.DataPoint
 */
annotate service.ChildEntities1 with @(
    UI.DataPoint #fieldWithPercent : {
        Value           : fieldWithPerCent,
        Title           : '{i18n>fieldWithPerCent}',
        Visualization   : #Number,
    },
);

/**
    UI.PresentationVariant
 */
annotate service.ChildEntities1 with @(
    UI.PresentationVariant : {
        SortOrder       : [
            {
                Property    : field,
                Descending  : false,
            },
        ],
        Visualizations  : ['@UI.LineItem'],
    },
);
/**
    UI.SelectionVariant
 */
annotate service.ChildEntities1 with @(
    //If more then 3 variants are enabled, they are displayed as a dropdown menu
    UI.SelectionVariant #variant1 : {
        Text            : '{i18n>variant1ChildEntities1}',
        SelectOptions   : [
            {
                PropertyName    : criticalityValue_code,
                Ranges          : [
                    {
                        Sign    : #I,
                        High    : 5,
                        Option  : #BT,
                        Low     : 0,
                    },
                ],
            },
        ],
    },
    UI.SelectionVariant #variant2 : {
        Text            : '{i18n>variant2ChildEntities1}',
        SelectOptions   : [
            {
                PropertyName    : criticalityValue_code,
                Ranges          : [
                    {
                        Sign    : #I,
                        Option  : #EQ,
                        Low     : 3,
                    },
                ],
            },
        ],
    },
    UI.SelectionVariant #variant3 : {
        Text            : '{i18n>variant3ChildEntities1}',
        SelectOptions   : [
            {
                PropertyName    : criticalityValue_code,
                Ranges          : [
                    {
                        Sign    : #I,
                        Option  : #EQ,
                        Low     : 2,
                    },
                ],
            },
        ],
    },
    UI.SelectionVariant #variant4 : {
        Text            : '{i18n>variant4ChildEntities1}',
        SelectOptions   : [
            {
                PropertyName    : criticalityValue_code,
                Ranges          : [
                    {
                        Sign    : #I,
                        Option  : #EQ,
                        Low     : 1,
                    },
                ],
            },
        ],
    },
);
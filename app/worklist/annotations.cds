using WorkListODataService as srv from '../../srv/worklist-srv';

annotate srv.Orders with {
    ID
    @title: '{i18n>OrderID}'
    @(Common: {
        Text           : stringProperty,
        TextArrangement: #TextOnly,
        ValueList      : {
            Label         : '{i18n>ORDERS}}',
            CollectionPath: 'Orders',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    ValueListProperty: 'ID',
                    LocalDataProperty: ID,
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'stringProperty',
                }
            ]
        }
    });
};

annotate srv.Orders with @(
    UI.SelectionFields                            : [
        ID,
        stringProperty,
        country_code,
    ],
    UI.LineItem                                   : [
        {Value: stringProperty, },
        {Value: integerProperty, },
        {Value: decimalProperty, },
        {Value: country_code, },
    ],
    // Search-Term: #DefaultSortFilter
    UI.SelectionPresentationVariant #DefaultFilter: {
        SelectionVariant   : {SelectOptions: [{
            PropertyName: integerProperty,
            Ranges      : [{
                Sign  : #I,
                Option: #GE,
                Low   : 0,
            }, ],
        }, ], },
        PresentationVariant: {
            SortOrder     : [{Property: country_code, }, ],
            Visualizations: ['@UI.LineItem'],
        },
    },
);

annotate srv.Orders with @(
    UI.HeaderInfo       : {
        TypeName      : '{i18n>ORDER}',
        TypeNamePlural: '{i18n>ORDERS}',
        Title         : {Value: stringProperty}
    },
    UI.Facets           : [
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#props',
            Label : '{i18n>generalData}'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: 'items/@UI.PresentationVariant',
            Label : '{i18n>OrderItems}'
        },
    ],
    UI.FieldGroup #props: {Data: [
        {Value: country_code},
        {Value: decimalProperty},
        {Value: integerProperty}
    ]}
);

annotate srv.OrderItems with @(
    UI.HeaderInfo                        : {
        TypeName      : '{i18n>OrderItem}',
        TypeNamePlural: '{i18n>OrderItems}',
        Title         : {Value: product}
    },
    UI.PresentationVariant               : {
        SortOrder     : [{Property: netValue, }, ],
        GroupBy       : [productCategory],
        Total         : [netValue],
        Visualizations: [@UI.LineItem]
    },
    UI.LineItem                          : [
        {Value: product},
        {Value: productCategory},
        {Value: netValue},
        {Value: currency_code},
    ],
    Aggregation.ApplySupported           : {
        AggregatableProperties: [{Property: netValue, }, ],
        GroupableProperties   : [
            currency_code,
            product,
            productCategory
        ]
    },
    Aggregation.CustomAggregate #netValue: 'Edm.Decimal',
) {
    netValue  @Analytics.Measure: true  @Aggregation.default: #SUM;
};

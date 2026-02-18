using WorkListODataService as srv from '../../srv/worklist-srv';

annotate srv.Deliveries with @(
    UI.SelectionFields  : [
        stringProperty,
        deliveryDate,
        trackingId
    ],
    UI.LineItem         : [
        {Value: deliveryDate, },
        {Value: trackingId, },
    ],
    UI.HeaderInfo       : {
        TypeName      : '{i18n>DELIVERY}',
        TypeNamePlural: '{i18n>DELIVERIES}',
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
            Target: 'items/@UI.LineItem',
            Label : '{i18n>DeliveryItems}'
        },
    ],
    UI.FieldGroup #props: {Data: [
        {Value: deliveryDate},
        {Value: trackingId},
    ]}
);

annotate srv.DeliveryItems with @(
    UI.HeaderInfo: {
        TypeName      : '{i18n>DeliveryItem}',
        TypeNamePlural: '{i18n>DeliveryItems}',
        Title         : {Value: product}
    },
    UI.LineItem  : [{Value: product}, ],
) {};

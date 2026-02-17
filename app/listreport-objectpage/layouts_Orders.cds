using LROPODataService as srv from '../../srv/list-report-srv';

// UI.FieldGroup
annotate srv.Orders with @(UI.FieldGroup #data: {Data: [
    {
        Value               : stringProperty,
        @Common.FieldControl: #ReadOnly
    },
    {
        Value               : integerProperty,
        @Common.FieldControl: #ReadOnly
    },
    {
        Value               : decimalProperty,
        @Common.FieldControl: #ReadOnly
    },
    {
        Value               : country_code,
        @Common.FieldControl: #ReadOnly
    }
], }, ) {
    country  @Common.Text: country.name  @Common.TextArrangement #TextFirst;
};

// UI.HeaderInfo
// Search-Term: #QuickView
annotate srv.Orders with @(
    //Header Info is also displayed in a quick view facet
    UI.HeaderInfo: {
        TypeName      : '{i18n>Order}',
        TypeNamePlural: '{i18n>Order.typeNamePlural}',
        Title         : {
            $Type: 'UI.DataField',
            Value: '{i18n>Order}',
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: stringProperty,
        },
        ImageUrl      : '',
        TypeImageUrl  : 'sap-icon://blank-tag',
    },
    UI.LineItem  : [{Value: stringProperty}]
);

// UI.QuickViewFacets
// Search-Term: #QuickView
annotate srv.Orders with @(
                           // When a semantic object for the entity is defined, the related apps will be shown
                           // below the quick view facet on the panel.
                         UI.QuickViewFacets: [{
    $Type : 'UI.ReferenceFacet',
    Target: '@UI.FieldGroup#data',
    Label : '{i18n>Order}',
}], );

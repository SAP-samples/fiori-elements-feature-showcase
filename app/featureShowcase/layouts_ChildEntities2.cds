using service1 as service from '../../srv/service';

/**
    UI.FieldGroup
 */
annotate service1.ChildEntities2 with @(
    UI.FieldGroup #data : {
        Data    : [
            {Value : stringProperty, @Common.FieldControl : #ReadOnly},
            {Value : integerProperty, @Common.FieldControl : #ReadOnly},
            {Value : decimalProperty, @Common.FieldControl : #ReadOnly},
            {Value : country_code, @Common.FieldControl : #ReadOnly}
        ],
    },
) {
    country @Common.Text : country.name @Common.TextArrangement #TextFirst;
};

/**
    UI.HeaderInfo
    Search-Term: #QuickView
 */
annotate service1.ChildEntities2 with @(
    //Header Info is also displayed in a quick view facet
    UI.HeaderInfo : {
        TypeName        : '{i18n>ChildEntity2}',
        TypeNamePlural  : '{i18n>ChildEntity2.typeNamePlural}',
        Title           : {
            $Type : 'UI.DataField',
            Value : '{i18n>ChildEntity2}',
        },
        Description     : {
            $Type : 'UI.DataField',
            Value : stringProperty,
        },
        ImageUrl        : '',
        TypeImageUrl    : 'sap-icon://blank-tag',
    },
);

/**
    UI.QuickViewFacets
    Search-Term: #QuickView
 */
annotate service1.ChildEntities2 with @(
    /*
    When a semantic object for the entity is defined, the related apps will be shown 
    below the quick view facet on the panel.
    */
    UI.QuickViewFacets : [
        {
            $Type   : 'UI.ReferenceFacet',
            Target  : '@UI.FieldGroup#data',
            Label   : '{i18n>ChildEntity2}',
        }
    ],
);
using LROPODataService as srv from '../../srv/list-report-srv';

annotate srv.OrganizationalUnits with @(
    odata.draft.enabled,
    UI.HeaderInfo : {
        TypeName : '{i18n>OrganizationalUnit}',
        TypeNamePlural : '{i18n>OrganizationalUnits}',
        Title : {
            Value: name
        },
        Description : {
            Value : externalId
        },
    },
    UI.SelectionVariant #activeOrgUnits : {
        Text : '{i18n>OrganizationalUnits}',
        SelectOptions : [
            {
                PropertyName : isActive,
                Ranges : [
                    {
                        Sign : #I,
                        Option : #EQ,
                        Low : true,
                    },
                ],
            },
        ]
    },
    UI.LineItem : [
        {
            Value : externalId,
        },
        {
            Value : name,
        },
        {
            Value : category_code,
        },
        {
            Value : isActive,
        },
    ],
    UI.FieldGroup #creationDialog : {
        Data : [
            {
                Value : name,
            },
            {
                Value : description,
            },
        ]
    }
);
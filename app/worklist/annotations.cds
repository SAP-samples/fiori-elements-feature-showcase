using WorkListODataService as srv from '../../srv/worklist-srv';
annotate srv.ChildEntities2 with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : stringProperty,
        },
        {
            $Type : 'UI.DataField',
            Value : integerProperty,
        },
        {
            $Type : 'UI.DataField',
            Value : decimalProperty,
        },
    ],
    UI.SelectionFields : [
        stringProperty,
        integerProperty,
        decimalProperty  
    ]
);

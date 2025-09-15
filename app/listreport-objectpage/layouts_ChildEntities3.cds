using LROPODataService as srv from '../../srv/list-report-srv';

/**
    UI.LineItem
 */
annotate srv.ChildEntities3 with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : field,
        },
    ],
);
using service1 as service from '../../srv/service';

/**
    UI.LineItem
 */
annotate service1.GrandChildEntities with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : field,
        },
    ],
);
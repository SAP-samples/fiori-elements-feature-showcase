using service1 as service from '../../srv/service';

/**
    UI.LineItem
 */
annotate service1.ChildEntities3 with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : field,
        },
    ],
);
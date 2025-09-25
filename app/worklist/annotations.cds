using WorkListODataService as srv from '../../srv/worklist-srv';
annotate srv.ChildEntities2 with @(
    UI.LineItem : [
        {
            Value : stringProperty,
        },
        {
            Value : integerProperty,
        },
        {
            Value : decimalProperty,
        },
        {
            Value : country_code,
        },
    ],
    // Search-Term: #DefaultSortFilter
    UI.SelectionPresentationVariant #DefaultFilter : {
        SelectionVariant    : {
            SelectOptions   : [
                {
                    PropertyName    : integerProperty,
                    Ranges          : [
                        {
                            Sign    : #I,
                            Option  : #GE,
                            Low     : 0,
                        },
                    ],
                },
            ],
        },
        PresentationVariant : {
            SortOrder       : [
                {
                    Property : country_code,
                },
            ],
            Visualizations  : ['@UI.LineItem'],
        },
    },
);

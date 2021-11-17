using service1 as service from '../../srv/service';

/**
    UI.LineItem
 */
annotate service1.RootEntityVariants with @(
    UI.LineItem : [
        {
            $Type                       : 'UI.DataField',
            Value                       : stringProperty,
            ![@UI.Importance]           : #High,
        },
        {
            $Type                       : 'UI.DataField',
            Value                       : fieldWithPrice,
            ![@UI.Importance]           : #High,
        },
        {
            $Type                       : 'UI.DataField',
            Value                       : fieldWithUoM,
            ![@UI.Importance]           : #High,
        },
        {
            $Type                       : 'UI.DataField',
            Value                       : fieldWithCriticality,
            Criticality                 : criticality_code,
            CriticalityRepresentation   : #WithIcon,
            ![@UI.Importance]           : #High,
        },
    ],
);

/**
    UI.SelectionVariant
 */
annotate service1.RootEntityVariants with @(
    UI.SelectionVariant #variant3 : {
        Text            : '{i18n>variant3RootEntityVariants}',
        SelectOptions   : [
            {
                PropertyName    : criticality_code,
                Ranges          : [
                    {
                        Sign    : #I,
                        High    : 3,
                        Option  : #BT,
                        Low     : 0,
                    },
                ],
            },
        ],
    },
    UI.SelectionVariant #variant1 : {
        Text            : '{i18n>variant1ForRootEntityVariants}',
        SelectOptions   : [
            {
                PropertyName    : criticality_code,
                Ranges          : [
                    {
                        Sign    : #I,
                        High    : 2,
                        Option  : #BT,
                        Low     : 0,
                    },
                ],
            },
        ],
    },
    UI.SelectionVariant #variant2 : {
        Text            : '{i18n>variant2ForRootEntityVariants}',
        SelectOptions   : [
            {
                PropertyName    : criticality_code,
                Ranges          : [
                    {
                        Sign    : #I,
                        Option  : #EQ,
                        Low     : 3,
                    },
                ],
            },
        ],
    },
);

/**
    UI.SelectionPresentationVariant
 */
annotate service1.RootEntityVariants with @(
    UI.SelectionPresentationVariant #SelectionPresentationVariant : {
        Text                : '{i18n>SPV for RootEntityVariants}',
        SelectionVariant    : {
            SelectOptions   : [
                {
                    PropertyName    : criticality_code,
                    Ranges          : [
                        {
                            Sign    : #I,
                            High    : 2,
                            Option  : #BT,
                            Low     : 0,
                        },
                    ],
                },
            ],
        },
        PresentationVariant : {
            SortOrder       : [
                {
                    Property    : fieldWithPrice,
                    Descending  : false,
                },
            ],
        },
    },
);

using LROPODataService as srv from '../../srv/list-report-srv';

annotate srv.RootEntities with @odata.draft.enabled; //Search-Term: #Draft

annotate srv.RootEntities with @(
    //Disables the delete option dependent of the fields value
    Capabilities.DeleteRestrictions: {Deletable: deletePossible, //Search-Term: #DynamicCRUD
    },
    /* Capabilities.UpdateRestrictions : {
        Updatable : updatePossible, //UpdateRestrictions are ignored in determining if the edit button is visible or not, but it still affects wheather the fields are editable or not
    }, */
    UI.UpdateHidden                : updateHidden, //Search-Term: #DynamicCRUD

    UI.CreateHidden                : {$edmJson: {$Path: '/Singleton/createHidden'}}, //Search-Term: #DynamicCRUD

    Capabilities.FilterRestrictions: {FilterExpressionRestrictions: [{
        //Search-Term: #SemanticDateFilter
        Property          : 'validFrom',
        AllowedExpressions: 'SingleRange' //Other option: SingleValue
    }, ],
    // RequiredProperties : [
    //     stringProperty //Search-Term: #RequiredFilter
    // ]
    },
) {
    validTo @UI.DateTimeStyle: 'short'
};

annotate LROPODataService with @(Capabilities.FilterFunctions: ['tolower' //Search-Term: #CaseInsensitiveFiltering
], );

annotate srv.ChartDataEntities with @(
                                      //Search-Term: #ChartSection
                                    Aggregation.ApplySupported: {
    GroupableProperties   : [
        dimensions,
        criticality_code
    ],
    AggregatableProperties: [{Property: integerValue}, ],
});

annotate srv.ChartDataEntities with {
    //Search-Term: #ChartSection
    criticality  @(UI.ValueCriticality: [
        {
            Value      : 0,
            Criticality: #Neutral
        },
        {
            Value      : 1,
            Criticality: #Negative
        },
        {
            Value      : 2,
            Criticality: #Critical
        },
        {
            Value      : 3,
            Criticality: #Positive
        }
    ]);

    integerValue @(
        Measures.ISOCurrency: uom_code,
        Core.Immutable      : true,
    );
};

// Search-Term: #TreeTable
annotate srv.OrganizationalUnits @(
    Aggregation.RecursiveHierarchy #OrgUnitsHierarchy     : {
        ParentNavigationProperty: superOrdinateOrgUnit, // navigates to a node's parent
        NodeProperty            : ID, // identifies a node, usually the key
    },
    Hierarchy.RecursiveHierarchyActions #OrgUnitsHierarchy: {
        ChangeSiblingForRootsSupported: true,
        // Disables move up/down of root nodes. Does not disable promotion of child nodes!
        ChangeNextSiblingAction       : 'LROPODataService.moveOrgUnit',
        CopyAction                    : 'LROPODataService.copyOrgUnit',
    },
// To disable cut, paste & drag & drop & move up & down. Copy & Paste still allowed
// Be aware this currently does only affect the UI but not enforce the restriction on API level!
// Capabilities: {UpdateRestrictions: {NonUpdatableNavigationProperties: [superOrdinateOrgUnit]}}
);

// Fiori expects the following to be defined explicitly, even though they're always the same
extend srv.OrganizationalUnits with @(
    // The columns expected by Fiori to be present in hierarchy entities
    Hierarchy.RecursiveHierarchy #OrgUnitsHierarchy        : {
        LimitedDescendantCount: LimitedDescendantCount,
        DistanceFromRoot      : DistanceFromRoot,
        DrillState            : DrillState,
        LimitedRank           : LimitedRank
    },
    // Disallow filtering on these properties from Fiori UIs
    Capabilities.FilterRestrictions.NonFilterableProperties: [
        'LimitedDescendantCount',
        'DistanceFromRoot',
        'DrillState',
        'LimitedRank'
    ],
    // Disallow sorting on these properties from Fiori UIs
    Capabilities.SortRestrictions.NonSortableProperties    : [
        'LimitedDescendantCount',
        'DistanceFromRoot',
        'DrillState',
        'LimitedRank'
    ],
) columns { // Ensure we can query these fields from database
    null as LimitedDescendantCount : Int16,
    null as DistanceFromRoot       : Int16,
    null as DrillState             : String,
    null as LimitedRank            : Int16,
};

using LROPODataService as srv from '../../srv/list-report-srv';

//
// annotations that control the behavior of fields and actions
//

annotate srv.RootEntities {
    ID                @UI.Hidden        @readonly   @mandatory  @UI.ExcludeFromNavigationContext;
    stringProperty    @Core.Immutable   @mandatory  @UI.ExcludeFromNavigationContext; //Search-Term: #CreationDialog
    uom               @UI.Hidden;

    association2one   @(
        //Search-Term: #Navigation
        //Semantic Object annotation in order to show the links to the semantic object apps in the quick view facet
        Common.SemanticObject       : 'FeatureShowcaseOrder',
        Common.SemanticObjectMapping: [
            {
                // Map local property to the target object ID
                $Type                 : 'Common.SemanticObjectMappingType',
                LocalProperty         : association2one_ID,
                SemanticObjectProperty: 'ID',
            },
            {
                // Semantic object mapping is done, to set filter values when navigation to the semantic object map
                // No logical sense behind the connection - just to demonstrate
                $Type                 : 'Common.SemanticObjectMappingType',
                LocalProperty         : integerValue,
                SemanticObjectProperty: 'field3',
            },
        ],
    );

    fieldWithURLtext  @UI.HiddenFilter  @HTML5.LinkTarget: '_blank'; //Search-Term: #HideFilter, #Link

    /** Search-Term: #FilterDefault
        For a default filter value in the list report. Does not support complex values */
    //stringProperty @Common.FilterDefaultValue : 'Root entity 4';

    region            @UI.HiddenFilter; //Filter not available in the list report
    deletePossible    @UI.Hidden;
    updateHidden      @UI.Hidden;
    fieldWithURL      @UI.Hidden;

    email             @mandatory;
};

annotate srv.RootEntities actions {
    //Search-Terms: #SideEffect, #ParameterDefaultValue
    changeProgress @(
        //Update the UI after action
        Common.SideEffects     : {TargetProperties: [
            ($self.criticality_code),
            'in/integerValue'
        ]},
        Core.OperationAvailable: ($self.integerValue > 0)
    )
}


annotate srv.ChildEntities1 {
    ID     @UI.Hidden       @readonly  @mandatory;
    parent @UI.Hidden;
    field  @Core.Immutable  @mandatory;
};

annotate srv.criticalAction with @(Common.IsActionCritical: true //Search-Term: #CriticalAction
);

annotate srv.GrandChildEntities {
    ID     @UI.Hidden  @readonly  @mandatory;
    parent @UI.Hidden;
};

annotate srv.Orders {
    ID  @UI.Hidden  @readonly  @mandatory;
};

annotate srv.ChartDataEntities {
    ID                                @UI.Hidden  @readonly  @mandatory;
    parent                            @UI.Hidden  @Core.Immutable;

    areaChartDeviationLowerBoundValue @UI.HiddenFilter;
    areaChartDeviationUpperBoundValue @UI.HiddenFilter;
    areaChartToleranceLowerBoundValue @UI.HiddenFilter;
    areaChartToleranceUpperBoundValue @UI.HiddenFilter;
}

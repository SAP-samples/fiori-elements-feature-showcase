using service1 from '../../srv/service';

//
// annotations that control the behavior of fields and actions
//

annotate service1.RootEntities {
    ID              @UI.Hidden @readonly        @mandatory @UI.ExcludeFromNavigationContext;
    stringProperty             @Core.Immutable  @mandatory @UI.ExcludeFromNavigationContext; //Search-Term: #CreationDialog
    uom             @UI.Hidden;

    association2one @(
        //Search-Term: #Navigation
        //Semantic Object annotation in order to show the links to the semantic object apps in the quick view facet
        Common.SemanticObject : 'FeatureShowcaseChildEntity2',
        Common.SemanticObjectMapping : [
            {
                // Semantic object mapping is done, to set filter values when navigation to the semantic object map
                // No logical sensen behind the connection - just to demonstrate
                $Type : 'Common.SemanticObjectMappingType',
                LocalProperty : integerValue,
                SemanticObjectProperty : 'field3',
            },
        ], 
    );
    
    fieldWithURLtext                    @UI.HiddenFilter @HTML5.LinkTarget : '_blank'; //Search-Term: #HideFilter, #Link

    /** Search-Term: #FilterDefault
        For a default filter value in the list report. Does not support complex values */ 
    //stringProperty @Common.FilterDefaultValue : 'Root entity 4'; 
    
    region                              @UI.HiddenFilter; //Filter not available in the list report
    deletePossible                      @UI.Hidden;
    updateHidden                        @UI.Hidden;
    fieldWithURL                        @UI.Hidden;

    email @mandatory;
};

annotate service1.RootEntities actions {
    //Search-Terms: #SideEffect, #ParameterDefaultValue
    changeProgress  @(
        //Update the UI after action
        Common.SideEffects              : {
            TargetProperties : ['in/integerValue']
        },
        Core.OperationAvailable: {$edmJson: {$If: [{$Ge: [{$Path: 'in/integerValue'}, 0]}, true, false]}}
    )
}


annotate service1.ChildEntities1 {
    ID      @UI.Hidden @readonly @mandatory;
    parent  @UI.Hidden;
    field @Core.Immutable @mandatory;
};

annotate service1.criticalAction with @(
    Common.IsActionCritical : true //Search-Term: #CriticalAction
);

annotate service1.GrandChildEntities {
    ID      @UI.Hidden @readonly @mandatory;
    parent  @UI.Hidden;
};

annotate service1.ChildEntities2 {
    ID      @UI.Hidden @readonly @mandatory;
};

annotate service1.ChartDataEntities {
    ID      @UI.Hidden @readonly @mandatory;
    parent  @UI.Hidden @Core.Immutable;

    areaChartDeviationLowerBoundValue   @UI.HiddenFilter;
    areaChartDeviationUpperBoundValue   @UI.HiddenFilter;
    areaChartToleranceLowerBoundValue   @UI.HiddenFilter;
    areaChartToleranceUpperBoundValue   @UI.HiddenFilter;
}
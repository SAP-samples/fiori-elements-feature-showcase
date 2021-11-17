using {sap.fe.featureShowcase as persistence} from '../db/schema';
using {sap.common as common} from '../db/common';

service service1 @(path : '/srv1') {

    @Capabilities.SortRestrictions.NonSortableProperties : [createdAt,createdBy,modifiedAt,modifiedBy]
    entity RootEntities as select from persistence.RootEntities actions {
        //Search-Terms: #BoundAction, #SideEffect
        @(
            //Update the UI after action
            cds.odata.bindingparameter.name : '_it',
            Common.SideEffects              : {
                TargetProperties : ['_it/criticality_code','_it/fieldWithCriticality']
            }
        )
        action changeCriticality (
            //Value Helper for the Input Parameter
            //Search-Term: #ValueHelpParameter
            @(
                title                       : '{i18n>newCriticality}',
                UI.ParameterDefaultValue    : _it.criticality_code,
                Common : {
                    ValueListWithFixedValues : true,
                    ValueList : {
                        Label          : '{i18n>Criticality}',
                        CollectionPath : 'Criticality',
                        Parameters     : [
                            {
                                $Type             : 'Common.ValueListParameterInOut',
                                ValueListProperty : 'code',
                                LocalDataProperty : newCriticality
                            },
                            {
                                $Type             : 'Common.ValueListParameterDisplayOnly',
                                ValueListProperty : 'name'
                            },
                        ]
                    }
                }
            )
            newCriticality : Integer
        );

        //Search-Terms: #BoundAction, #SideEffect, #ParameterDefaultValue
        @(
            //Update the UI after action
            cds.odata.bindingparameter.name : '_it',
            Common.SideEffects              : {
                TargetProperties : ['_it/integerValue']
            }
        )
        action changeProgress (
            @(
                title                       : '{i18n>newProgress}', 
                UI.ParameterDefaultValue    : 50
            )
            newProgress : Integer
        );

        @(
            //Update the UI after action
            cds.odata.bindingparameter.name : '_it',
            cds.odata.bindingparameter.collection,
            Common.SideEffects              : {
                TargetEntities : [_it]
            }
        )
        action resetEntities();
    };
    //Search-Terms: #UnboundAction
    action unboundAction(@(title : '{i18n>inputValue}')input : String);

    action criticalAction();


    entity ChildEntities1       as projection on persistence.ChildEntities1;
    entity ChildEntities2       as projection on persistence.ChildEntities2;
    entity ChildEntities3       as projection on persistence.ChildEntities3;

    entity ChartDataEntities    as projection on persistence.ChartDataEntities;
    entity GrandChildEntities   as projection on persistence.GrandChildEntities;
    
    @readonly
    entity RootEntityVariants   as projection on persistence.RootEntityVariants;
    @readonly
    entity Contacts             as projection on persistence.Contacts;

    //Entity used for semantic key filter
    @odata.draft.enabled : false
    @readonly
    entity RootEntitySemanticKeys as select from RootEntities {
        stringProperty
    };

    @readonly
    entity Countries             as projection on common.Countries;
    @readonly
    entity Currencies            as projection on common.Currencies;
    @readonly
    entity Criticality           as projection on common.Criticality;
    @readonly
    entity UnitOfMeasureCodeList as projection on common.UnitOfMeasureCodeList;
}

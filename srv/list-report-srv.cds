using {sap.fe.showcase as persistence} from '../db/schema';
using {sap.common as common} from '../db/common';

// Search-Term: #CustomUnitScale
@CodeList.UnitsOfMeasure: {
    Url           : './$metadata',
    CollectionPath: 'UnitOfMeasures',
}
@requires               : 'authenticated-user'
service LROPODataService @(path: '/srv1') {

            @Capabilities.SortRestrictions.NonSortableProperties: [
        createdAt,
        createdBy,
        modifiedAt,
        modifiedBy
    ]
    entity RootEntities           as select from persistence.RootEntities
        actions {
            //Search-Terms: #BoundAction, #SideEffect
            @(
            //Update the UI after action
            Common.SideEffects: {TargetProperties: [
                'in/criticality_code',
                'in/fieldWithCriticality'
            ]})
            action changeCriticality(
                                     //Value Helper for the Input Parameter
                                     //Search-Term: #ValueHelpParameter
                                     @(
                                         title: '{i18n>newCriticality}',
                                         UI.ParameterDefaultValue: in.criticality_code,
                                         Common: {
                                             ValueListWithFixedValues: true,
                                             ValueList               : {
                                                 Label         : '{i18n>criticality}',
                                                 CollectionPath: 'Criticality',
                                                 Parameters    : [
                                                     {
                                                         $Type            : 'Common.ValueListParameterInOut',
                                                         ValueListProperty: 'code',
                                                         LocalDataProperty: newCriticality
                                                     },
                                                     {
                                                         $Type            : 'Common.ValueListParameterDisplayOnly',
                                                         ValueListProperty: 'name'
                                                     },
                                                 ]
                                             }
                                         }
                                     )
                                     newCriticality: Integer);

            //Search-Term: #BoundAction
            action changeProgress(
                                  @(
                                      title: '{i18n>newProgress}',
                                      UI.ParameterDefaultValue: 50
                                  )
                                  newProgress: Integer);

            @(
            //Update the UI after action
            Common.SideEffects: {TargetEntities: [in]})
            action resetEntities(in: many $self);
        };

    //Search-Terms: #UnboundAction
    @Core.OperationAvailable: {$edmJson: {$Path: '/Singleton/enabled'}}
    action unboundAction( @(title: '{i18n>inputValue}') input: String);

    action criticalAction();


    entity ChildEntities1         as projection on persistence.ChildEntities1;

    @cds.redirection.target
    entity Orders                 as projection on persistence.Orders;

    entity ChildEntities3         as projection on persistence.ChildEntities3;

    entity ChartDataEntities      as projection on persistence.ChartDataEntities;
    entity GrandChildEntities     as projection on persistence.GrandChildEntities;

    @odata.draft.bypass
    entity OrganizationalUnits    as projection on persistence.OrganizationalUnits
                                     order by
                                         rank
        actions {
            action copyOrgUnit() returns OrganizationalUnits;

            action moveOrgUnit(
                               // OrganizationalUnits cannot be used as the type because for the associations UI5 would additional properties
                               // Any property, which is part of OrganizationalUnits and which UI5 has in context will be passed
                               NextSibling: {
                ID : UUID
            });
        };

    @readonly
    entity Contacts               as projection on persistence.Contacts;

    //Entity used for semantic key filter
    @odata.draft.enabled: false
    @readonly
    // The annotations are overriden from RootEntities to avoid fault metadata
    @UI.LineItem        : []
    @UI.Facets          : []
    entity RootEntitySemanticKeys as
        select from RootEntities {
            key stringProperty
        };

    @readonly
    entity Countries              as projection on common.Countries;

    @readonly
    entity Currencies             as projection on common.Currencies;

    @readonly
    entity Criticality            as projection on common.Criticality;

    @readonly
    entity UnitOfMeasures         as projection on common.UnitOfMeasures;

    @odata.singleton
    @readonly
    entity Singleton {
        createHidden : Boolean;
        enabled      : Boolean;
    };
}

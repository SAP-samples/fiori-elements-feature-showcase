using {
    Country,
    sap.common.CodeList as CodeList,
    cuid,
    Currency,
    managed,
    sap,
} from '@sap/cds/common';
using {
    sap.common.Region,
    sap.common.UnitOfMeasure,
    sap.common.Criticality
} from '../db/common.cds';

namespace sap.fe.featureShowcase;

aspect rootBasis : {
    imageUrl                    : String;
    stringProperty              : String;
    integerValue                : Integer;
    forecastValue               : Integer;
    targetValue                 : Integer default 30;
    dimensions                  : Integer;
            
    starsValue                  : Decimal;
            
    contact                     : Association to one Contacts;
    criticality_code            : Integer;
    criticality                 : Association to one Criticality on criticality.code = criticality_code;

    fieldWithUoM                : Decimal(15,3);
    uom                         : UnitOfMeasure;

    fieldWithPrice              : Decimal(12,3);     
    isoCurrency                 : Currency;

    fieldWithCriticality        : String;

    deletePossible              : Boolean;
    updateHidden                : Boolean;
    fieldWithURL                : String;
    fieldWithURLtext            : String;

    email                       : String;
    telephone                   : String;

    country                     : Country;
    region                      : Region;

    validFrom                   : Date; //Search-Term: #TimeAndDate
    validTo                     : Date;
    time                        : Time;
    timeStamp                   : Timestamp;

    description                 : String(1000);
    description_customGrowing   : String(1000);
};

entity RootEntities : cuid, managed, rootBasis {
    childEntities1              : Composition of many ChildEntities1
                                    on childEntities1.parent = $self;
    childEntity2                : Association to one ChildEntities2;
    childEntities3              : Composition of many ChildEntities3
                                    on childEntities3.parent = $self;
    chartEntities               : Composition of many ChartDataEntities
                                    on chartEntities.parent = $self;
};

//Entity only used to demonstrate Multiple Views on List Report with multiple entities
entity RootEntityVariants : cuid, managed, rootBasis {};

entity ChildEntities1 : cuid {
    parent                      : Association to one RootEntities;
    field                       : String;
    fieldWithPerCent            : Decimal(5,2);
    booleanProperty             : Boolean default false;
    criticalityValue            : Association to one Criticality;
    grandChildren               : Composition of many GrandChildEntities 
                                    on grandChildren.parent = $self;
}

entity GrandChildEntities : cuid {
    parent                      : Association to one ChildEntities1;
    field                       : String;
}

//@cds.odata.valuelist -- enables automatic value list with keys on UI
entity ChildEntities2 : cuid {
    stringProperty              : String;
    integerProperty             : Integer;
    decimalProperty             : Decimal(5, 3);
    country                     : Country;
}

entity ChildEntities3 : cuid {
    parent                      : Association to one RootEntities;
    field                       : String;
}

entity ChartDataEntities : cuid {
    parent                      : Association to one RootEntities;
    criticality                 : Association to one Criticality;
    integerValue                : Integer;
    integerValueWithUoM         : Integer;
    uom                         : UnitOfMeasure;
    forecastValue               : Integer;
    targetValue                 : Integer default 30;
    dimensions                  : Integer;

    areaChartToleranceUpperBoundValue   : Integer default 90;
    areaChartToleranceLowerBoundValue   : Integer default 80;
    areaChartDeviationUpperBoundValue   : Integer default 50;
    areaChartDeviationLowerBoundValue   : Integer default 0;
}

entity Contacts : cuid {
    name                        : String;
    phone                       : String;
    building                    : String;
    country                     : Country;
    street                      : String;
    city                        : String;
    postCode                    : String;
    addressLabel                : String;
    photoUrl                    : String;
}
using {
                           Country,
    sap.common.CodeList as CodeList,
                           cuid,
                           Currency,
                           managed,
                           sap,
} from '@sap/cds/common';
using {
    sap.common.Regions,
    sap.common.UnitOfMeasures,
    sap.common.Criticality
} from '../db/common.cds';

namespace sap.fe.showcase;

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
    criticality                 : Association to one Criticality
                                      on criticality.code = criticality_code;

    fieldWithUoM                : Decimal(15, 3);
    uom                         : Association to one UnitOfMeasures;

    fieldWithPrice              : Decimal(12, 3);
    isoCurrency                 : Currency;

    fieldWithCriticality        : String;

    deletePossible              : Boolean;
    updateHidden                : Boolean;
    fieldWithURL                : String;
    fieldWithURLtext            : String;

    email                       : String;
    telephone                   : String;

    country                     : Country;
    regionWithConstantValueHelp : Association to one Regions;
    region                      : Association to one Regions;

    validFrom                   : Date; //Search-Term: #TimeAndDate
    validTo                     : DateTime;
    time                        : Time;
    timeStamp                   : Timestamp;

    description                 : String(1000);
    description_customGrowing   : String(1000);
};

entity RootEntities : cuid, managed, rootBasis {
    childEntities1  : Composition of many ChildEntities1
                          on childEntities1.parent = $self;
    association2one : Association to one Orders;
    childEntities3  : Composition of many ChildEntities3
                          on childEntities3.parent = $self;
    chartEntities   : Composition of many ChartDataEntities
                          on chartEntities.parent = $self;
    regions         : Composition of many AssignedRegions
                          on regions.root = $self;
};

entity ChildEntities1 : cuid {
    parent           : Association to one RootEntities;
    field            : String;
    fieldWithPerCent : Decimal(5, 2);
    booleanProperty  : Boolean default false;
    criticalityValue : Association to one Criticality;
    grandChildren    : Composition of many GrandChildEntities
                           on grandChildren.parent = $self;
}

entity GrandChildEntities : cuid {
    parent : Association to one ChildEntities1;
    field  : String;
}

//@cds.odata.valuelist -- enables automatic value list with keys on UI
entity Orders : cuid {
    stringProperty  : String;
    integerProperty : Integer;
    decimalProperty : Decimal(5, 3);
    country         : Country;
    items           : Composition of many OrderItems
                          on items.order = $self;
}

entity OrderItems : cuid {
    order           : Association to one Orders;
    product         : String;
    productCategory : String;
    netValue        : Decimal(6, 3);
    currency        : Currency;
}

entity Deliveries : cuid {
    order          : Association to one Orders;
    stringProperty : String;
    deliveryDate   : Date;
    trackingId     : String;
    items          : Composition of many DeliveryItems
                         on items.delivery = $self;
}

entity DeliveryItems : cuid {
    delivery : Association to one Deliveries;
    product  : String;
}

entity ChildEntities3 : cuid {
    parent : Association to one RootEntities;
    field  : String;
}

entity ChartDataEntities : cuid {
    parent                            : Association to one RootEntities;
    criticality                       : Association to one Criticality;
    integerValue                      : Integer;
    integerValueWithUoM               : Integer;
    uom                               : Association to one UnitOfMeasures;
    forecastValue                     : Integer;
    targetValue                       : Integer default 30;
    dimensions                        : Integer;

    areaChartToleranceUpperBoundValue : Integer default 90;
    areaChartToleranceLowerBoundValue : Integer default 80;
    areaChartDeviationUpperBoundValue : Integer default 50;
    areaChartDeviationLowerBoundValue : Integer default 0;
}

entity Contacts : cuid {
    name         : String;
    phone        : String;
    building     : String;
    country      : Country;
    street       : String;
    city         : String;
    postCode     : String;
    addressLabel : String;
    photoUrl     : String;
}

entity AssignedRegions : cuid {
    root   : Association to one RootEntities;
    region : Association to one Regions;
}

entity OrganizationalUnits : cuid {
    externalId           : String(128);
    rank                 : Integer default 0; //Sorting order
    name                 : localized String(128);
    description          : localized String(256);
    isActive             : Boolean default true;
    category             : Association to one OrganizationalUnitCategoryCodes;
    superOrdinateOrgUnit : Association to one OrganizationalUnits;
    subordinaryOrgUnits  : Association to many OrganizationalUnits
                               on subordinaryOrgUnits.superOrdinateOrgUnit = $self;

}

entity OrganizationalUnitCategoryCodes : CodeList {
    key code : String(2);
}

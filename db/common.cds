using { User, sap, managed, Country, sap.common.CodeList } from '@sap/cds/common';

//From cap-sflight
extend sap.common.Currencies with {
  // Currencies.code = ISO 4217 alphabetic three-letter code
  // with the first two letters being equal to ISO 3166 alphabetic country codes
  // See also:
  // [1] https://www.iso.org/iso-4217-currency-codes.html
  // [2] https://www.currency-iso.org/en/home/tables/table-a1.html
  // [3] https://www.ibm.com/support/knowledgecenter/en/SSZLC2_7.0.0/com.ibm.commerce.payments.developer.doc/refs/rpylerl2mst97.htm
  numcode  : Integer;
  exponent : Integer; //> e.g. 2 --> 1 Dollar = 10^2 Cent
  minor    : String; //> e.g. 'Cent'
}

type sap.common.Region : Association to sap.common.Regions;

entity sap.common.Regions : CodeList {
  key code    : String(10) @title : '{i18n>region}' @Common.Text : name @Common.TextArrangement : #TextFirst;
  key country : Country @UI.Hidden;
}

extend sap.common.Countries with {
  regions : Composition of many sap.common.Regions on regions.country = $self;
}

//
// Code Lists
//

entity sap.common.Criticality : sap.common.CodeList {
  key code    : Integer default 0 @Common.Text : name @Common.TextArrangement : #TextFirst;
}

entity sap.common.UnitOfMeasureCodeList : CodeList {
    key code  : String(30);
};

type sap.common.UnitOfMeasure : Association to one sap.common.UnitOfMeasureCodeList;

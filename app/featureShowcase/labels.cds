using { sap.fe.featureShowcase as schema } from '../../db/schema';

//
// annotations that control rendering of fields and labels
//

annotate schema.RootEntities with{
    childEntities1              @title : '{i18n>childEntities1}';
    stringProperty              @title : '{i18n>semanticKeyField}';
    integerValue                @title : '{i18n>integerValue}';
    forecastValue               @title : '{i18n>forecastValue}';
    targetValue                 @title : '{i18n>targetValue}';
    dimensions                  @title : '{i18n>dimensions}';
    starsValue                  @title : '{i18n>stars}';
    isoCurrency                 @title : '{i18n>currencyForFieldWithPrice}';
    fieldWithCriticality        @title : '{i18n>fieldWithCriticality}';
    contact                     @title : '{i18n>contact}';
    validFrom                   @title : '{i18n>date}';
    validTo                     @title : '{i18n>dateTo}';
    time                        @title : '{i18n>time}';
    timeStamp                   @title : '{i18n>timeStamp}';

    fieldWithPrice              @title : '{i18n>fieldWithPrice}'            @(Measures.ISOCurrency: isoCurrency_code ); //Search-Term: #Units
    fieldWithUoM                @title : '{i18n>fieldWithUoM}'              @(Measures.Unit : uom_code); //Search-Term: #Units
    imageUrl                    @title : '{i18n>image}'                     @UI.IsImageURL; //Displaying the image instead of the link //Search-Term: #Image
    
    childEntity2                @title : '{i18n>ChildEntity2}'              @Common.Text : childEntity2.stringProperty  @Common.TextArrangement : #TextOnly;
    criticality_code            @title : '{i18n>criticality}'               @Common.Text : criticality.name             @Common.TextArrangement : #TextFirst; //Search-Term: #DisplayTextAndID
    country                     @title : '{i18n>country}'                   @Common.Text : country.name                 @Common.TextArrangement : #TextFirst;

    description                 @title : '{i18n>description}'               @UI.MultiLineText;             //Search-Term: #MultiLineText
    description_customGrowing   @title : '{i18n>description2}'              @UI.MultiLineText   @UI.Placeholder : 'max.mustermann@sap.com';
    region                      @title : '{i18n>region}'                                        @UI.Placeholder : 'Select a region'; //Search-Term: #Placeholder
    email                       @title : '{i18n>email}'                     @Communication.IsEmailAddress; //Search-Term: #CommunicationFields
    telephone                   @title : '{i18n>telephone}'                 @Communication.IsPhoneNumber; //Search-Term: #CommunicationFields
};

annotate schema.ChildEntities1 with @title : '{i18n>childEntities1}' {
    field                       @title : '{i18n>field}';
    booleanProperty             @title : '{i18n>booleanProperty}';
    fieldWithPerCent            @title : '{i18n>fieldWithPerCent}'          @(Measures.Unit : '%'); //Search-Term: #Units
};

annotate schema.GrandChildEntities with @title : '{i18n>grandChildren}' {
    field                       @title : '{i18n>field}'
};

annotate schema.ChildEntities2 with @title : '{i18n>ChildEntity2}' {
    integerProperty             @title : '{i18n>integerProperty}';
    decimalProperty             @title : '{i18n>decimalProperty}';
    stringProperty              @title : '{i18n>stringProperty}'            @UI.MultiLineText; //MultiLineText for Descriptions (line break)
};

annotate schema.ChildEntities3 with @title : '{i18n>childEntities3}' {
    field                       @title : '{i18n>stringProperty}'
};

annotate schema.ChartDataEntities with {
    integerValue                @title : '{i18n>integerValue}';
    forecastValue               @title : '{i18n>forecastValue}';
    targetValue                 @title : '{i18n>targetValue}';
    dimensions                  @title : '{i18n>dimensions}';
    integerValueWithUoM                                                     @Measures.Unit : uom_code;
};

annotate schema.UnitOfMeasureCodeList with {
    code                        @title : '{i18n>unitCode}'                  @Common.Text : name @Common.TextArrangement : #TextOnly
};

annotate schema.Contacts with {
    ID                          @title : '{i18n>name}'                      @Common.Text : name @Common.TextArrangement : #TextOnly
};


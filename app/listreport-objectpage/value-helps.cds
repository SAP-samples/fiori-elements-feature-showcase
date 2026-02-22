using {sap.fe.showcase as schema} from '../../db/schema';

//
// annotations for value helps
// Search-Term: #ValueHelps
//

annotate schema.RootEntities with {
    uom                         @Common.ValueListWithFixedValues; //Instead of dialog box, the value help is a dropdown
    criticality_code            @(Common: {
        ValueListWithFixedValues: true,
        // Search-Term: #RadioButtons | Render Value help with radio buttons
        ValueListWithFixedValues.@Common.ValueListShowValuesImmediately,
        ValueList               : {
            Label         : '{i18n>criticality}',
            CollectionPath: 'Criticality',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                ValueListProperty: 'code',
                LocalDataProperty: criticality_code
            }, ]
        }
    });

    //To have a Value help when editing and to show the name instead of the UUID
    contact                     @(Common: {
        Text           : contact.name,
        TextArrangement: #TextOnly,
        ValueList      : {
            Label         : '{i18n>contact}',
            //Title of the value help dialog
            CollectionPath: 'Contacts',
            //Entities of the value help. Refers to an entity name from the CAP service
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    ValueListProperty: 'ID',
                    //Binding between ID and contact_ID, that everything works
                    LocalDataProperty: contact_ID
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    //Displays additional information from the entity set of the value help
                    ValueListProperty: 'country_code',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'city',
                }

            ]
        }
    });
    association2one             @(Common: {
        ValueListWithFixedValues: true,
        ValueList               : {
            Label         : '{i18n>Order}',
            CollectionPath: 'Orders',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    ValueListProperty: 'ID',
                    LocalDataProperty: association2one_ID
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'stringProperty',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'integerProperty',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'decimalProperty',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'country_code',
                }

            ]
        }
    });
    //Search-Term: #DependentFilter
    region                      @(Common: {
        Text                    : region.name,
        TextArrangement         : #TextFirst,
        ValueListWithFixedValues: true,
        ValueList               : {
            Label         : '{i18n>region}',
            CollectionPath: 'Regions',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    ValueListProperty: 'code',
                    LocalDataProperty: region_code
                },
                //To only show the connected values
                {
                    $Type            : 'Common.ValueListParameterFilterOnly',
                    ValueListProperty: 'country_code',
                },
                {
                    $Type            : 'Common.ValueListParameterIn',
                    //Input parameter used for filtering
                    LocalDataProperty: country_code,
                    ValueListProperty: 'country_code',
                },

            ]
        }
    });

    regionWithConstantValueHelp @(Common: {
        Text                    : regionWithConstantValueHelp.name,
        TextArrangement         : #TextFirst,
        ValueListWithFixedValues: true,
        ValueList               : {
            Label         : '{i18n>region}',
            CollectionPath: 'Regions',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    ValueListProperty: 'code',
                    LocalDataProperty: region_code
                },
                //To only show regions for Germany
                //Search-Term: #ConstantFilter
                {
                    $Type            : 'Common.ValueListParameterConstant',
                    ValueListProperty: 'country_code',
                    Constant         : 'DE',
                },
            ]
        }
    });

    organizationalUnit          @(Common: {
        Text                        : organizationalUnit.name,
        TextArrangement             : #TextFirst,
        ValueList                   : {
            Label         : '{i18n>OrganizationalUnit}',
            CollectionPath: 'OrganizationalUnits',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    ValueListProperty: 'ID',
                    LocalDataProperty: organizationalUnit_ID
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'description',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'category',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'superOrdinateOrgUnit_ID',
                }

            ]
        },
        ValueList #OrgUnitsHierarchy: {
            Label                       : '{i18n>OrganizationalUnitHierarchy}',
            CollectionPath              : 'OrganizationalUnits',
            PresentationVariantQualifier: 'OrgUnitsHierarchy',
            Parameters                  : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    ValueListProperty: 'ID',
                    LocalDataProperty: organizationalUnit_ID
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'description',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'category',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'superOrdinateOrgUnit_ID',
                }

            ]
        }
    });
};

annotate schema.AssignedRegions with {
    //Search-Term: #MultiValueWithDependentFilter
    region @(Common: {
        Text                    : region.name,
        TextArrangement         : #TextFirst,
        ValueListWithFixedValues: true,
        ValueList               : {
            Label         : '{i18n>region}',
            CollectionPath: 'Regions',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    ValueListProperty: 'code',
                    LocalDataProperty: region_code
                },
                {
                    $Type            : 'Common.ValueListParameterIn',
                    //Input parameter used for filtering
                    LocalDataProperty: root.country_code,
                    ValueListProperty: 'country_code',
                },

            ]
        }
    });
}

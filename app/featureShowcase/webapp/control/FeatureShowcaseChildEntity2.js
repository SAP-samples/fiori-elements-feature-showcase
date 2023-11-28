sap.ui.define([
    'sap/m/Link',
    'sap/fe/macros/field/FieldTemplating',
    'sap/m/MessageBox',
], function (
    Link,
    FieldTemplating,
    MessageBox,
) {
    'use strict';

    return Link.extend("sap.fe.featureShowcase.mainApp.control.FeatureShowcaseChildEntity2", {
        metadata: {
            manifest: "json"
        },
        renderer: {},

        // Implement the interface dictated by the templating process
        getTemplate: function (xml, internalField) {
            const text = FieldTemplating.getTextBinding(internalField.dataModelPath, internalField.formatOptions, true);

            return xml`<myApp:FeatureShowcaseChildEntity2
                xmlns="sap.m"
                xmlns:myApp="sap.fe.featureShowcase.mainApp.control"
                xmlns:core="sap.ui.core"
                id="${internalField.noWrapperId}"
                text="${text}"
                visible="${internalField.displayVisible}"
                wrapping="${internalField.wrap === undefined ? true : internalField.wrap}"
                ariaLabelledBy="${internalField.ariaLabelledBy}"
                emptyIndicatorMode="${internalField.emptyIndicatorMode}"
                customData:loadValue="${internalField.valueAsStringBindingExpression}"
            >
            </myApp:FeatureShowcaseChildEntity2>`;
        },

        // 
        init: function () {
            this.attachPress(oEvent => {
                MessageBox.show('I am a custom control, injected in a FE template');
            });
        },
    });
});

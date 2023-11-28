sap.ui.define([
    'sap/fe/core/AppComponent',
    'sap/fe/featureShowcase/mainApp/control/FeatureShowcaseChildEntity2', // To ensure the custom control is loaded during templating
], function(AppComponent) {
    'use strict';

    return AppComponent.extend("sap.fe.featureShowcase.mainApp.Component", {
        metadata: {
            manifest: "json"
        }
    });
});

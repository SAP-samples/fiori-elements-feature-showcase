import ExtensionAPI from 'sap/fe/templates/ObjectPage/ExtensionAPI';
import { Button$PressEvent } from 'sap/m/Button';
import MessageBox from 'sap/m/MessageBox';
import Controller from 'sap/ui/core/mvc/Controller';
import ControllerExtension, { Overrides } from 'sap/ui/core/mvc/ControllerExtension';
import Context from 'sap/ui/model/Context';
import ODataContextBinding from 'sap/ui/model/odata/v2/ODataContextBinding';

/**
 * @namespace sap.fe.showcase.lrop.ext.controller
 * @controller
 */
export default class RootEntityOPExtension extends ControllerExtension<ExtensionAPI> {
    messageBox() {
        MessageBox.alert("Button pressed");
    }
    enabled() {
        return true;
    }
    enabledForSingleSelect(_: ODataContextBinding, aSelectedContexts: [Context]) {
        if (aSelectedContexts && aSelectedContexts.length === 1) {
            return true;
        }
        return false;
    }

    toggleSideContent(_: ODataContextBinding) {
        // @ts-expect-error showSideContent not yet defined in type but exists
        this.showSideContent("customSectionQualifier");
    }
    toggleSideContentItem1(_: ODataContextBinding) {
        // @ts-expect-error showSideContent not yet defined in type but exists
        this.showSideContent("childEntities1Section");
    }

    //Search-Term: #EditFlowAPI
    onChangeCriticality(oEvent: Button$PressEvent) {
        const sActionName = "LROPODataService.changeCriticality";
        const mParameters = {
            contexts: oEvent.getSource().getBindingContext(),
            model: oEvent.getSource().getModel(),
            label: 'Confirm',	
            invocationGrouping: true 	
        };
        // @ts-expect-error editFlow not yet defined in type but exists
        this.editFlow.invokeAction(sActionName, mParameters); //SAP Fiori elements EditFlow API
    }
}

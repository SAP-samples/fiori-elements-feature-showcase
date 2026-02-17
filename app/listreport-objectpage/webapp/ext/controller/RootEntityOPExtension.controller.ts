import ExtensionAPI from "sap/fe/templates/ObjectPage/ExtensionAPI";
import { Button$PressEvent } from "sap/m/Button";
import MessageBox from "sap/m/MessageBox";
import ControllerExtension from "sap/ui/core/mvc/ControllerExtension";
import Context from "sap/ui/model/odata/v4/Context";
import ODataContextBinding from "sap/ui/model/odata/v4/ODataContextBinding";
import ODataModel from "sap/ui/model/odata/v4/ODataModel";

/**
 * @namespace sap.fe.showcase.lrop.ext.controller
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
    this.base.getExtensionAPI().showSideContent("customSectionQualifier");
  }
  toggleSideContentItem1(_: ODataContextBinding) {
    this.base.getExtensionAPI().showSideContent("childEntities1Section");
  }

  //Search-Term: #EditFlowAPI
  onChangeCriticality(oEvent: Button$PressEvent) {
    const sActionName = "LROPODataService.changeCriticality";

    this.base
      .getExtensionAPI()
      .getEditFlow()
      .invokeAction(sActionName, {
        contexts: oEvent.getSource().getBindingContext()! as Context,
        model: oEvent.getSource().getModel() as ODataModel,
        label: "Confirm",
        invocationGrouping: "ChangeSet",
      }); //SAP Fiori elements EditFlow API
  }
}

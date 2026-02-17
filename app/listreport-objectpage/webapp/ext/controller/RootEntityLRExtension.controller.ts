import ExtensionAPI from "sap/fe/templates/ListReport/ExtensionAPI";
import { Button$PressEvent } from "sap/m/Button";
import MessageBox from "sap/m/MessageBox";
import ControllerExtension from "sap/ui/core/mvc/ControllerExtension";
import Context from "sap/ui/model/odata/v4/Context";
import ODataContextBinding from "sap/ui/model/odata/v4/ODataContextBinding";

/**
 * @namespace sap.fe.showcase.lrop.ext.controller
 */
export default class RootEntityLRExtension extends ControllerExtension<ExtensionAPI> {
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

  onResetRating(_: Button$PressEvent) {
    // @ts-expect-error setFiltersValues has faulty type atm
    this.base.getExtensionAPI().setFilterValues("starsValue");
  }

  isCreateEnabled(value: String, parentContext?: Context) {
    switch (parentContext?.getProperty("category_code")) {
      case "03":
        return value === "02"; // Only Divisions under Business Units
      case "02":
        return value === "01"; // Only Departments under Divisions
      case "01":
        return false; // Nothing under Departments
      default:
        return value === "03"; // Only Business Units at root level
    }
  }

  isMoveToPositionAllowed(sourceContext: Context, parentContext?: Context) {
    switch (parentContext?.getProperty("category_code")) {
      case "03":
        return sourceContext?.getProperty("category_code") === "02";
      case "02":
        return sourceContext?.getProperty("category_code") === "01";
      case "01":
        return false; // Nothing under Departments
      default:
        return false;
    }
  }
  isNodeMovable(sourceContext: Context) {
    // Keep in mind getProperty does only return loaded property &
    // that via personalisation a user could hide properties assumed to exist
    return sourceContext.getProperty("name") !== "Compilance";
  }
  isNodeCopyable(sourceContext: Context) {
    return sourceContext.getProperty("name") !== "Compilance";
  }
  isCopyToPositionAllowed(sourceContext: Context, parentContext?: Context) {
    switch (parentContext?.getProperty("category_code")) {
      case "03":
        return (
          sourceContext?.getProperty("category_code") === "02" ||
          sourceContext?.getProperty("category_code") === "01"
        );
      case "02":
        return sourceContext?.getProperty("category_code") === "01";
      case "01":
        return false; // Nothing under Departments
      default:
        return false;
    }
  }
}

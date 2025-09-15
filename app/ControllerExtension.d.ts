/**
 * Helper to be able to define how to get the page specific extension API when writing a controller extension.
 */
declare module 'sap/ui/core/mvc/ControllerExtension' {
  import View from 'sap/ui/core/mvc/View';
  import AppComponent from 'sap/fe/core/AppComponent';
  import Controller from 'sap/ui/core/mvc/Controller';
  import EditFlow from 'sap/fe/core/controllerextensions/EditFlow';
  import IntentBasedNavigation from 'sap/fe/core/controllerextensions/IntentBasedNavigation';
  import ViewState from 'sap/fe/core/controllerextensions/ViewState';
  import Routing from 'sap/fe/core/controllerextensions/Routing';

  export default class ControllerExtension<ExtensionAPI> {
    override?: Overrides;
    base: {
      getExtensionAPI(): ExtensionAPI;
      getView(): View;
      getAppComponent(): AppComponent;
    };
  }

  export type Overrides<GenericController extends Controller = Controller> = {
    editFlow?: Partial<EditFlow>;
    intentBasedNavigation?: Partial<IntentBasedNavigation>;
    routing?: Partial<Routing>;
    viewState?: Partial<ViewState>;
  } & Partial<GenericController>;
}

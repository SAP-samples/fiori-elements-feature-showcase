/**
 * Helper to be able to define how to get the page specific extension API when writing a controller extension.
 */
declare module 'sap/ui/core/mvc/ControllerExtension' {
  import View from 'sap/ui/core/mvc/View';
  import AppComponent from 'sap/fe/core/AppComponent';
  import Controller from 'sap/ui/core/mvc/Controller';
  import EditFlow from 'sap/fe/core/controllerextensions/EditFlow';
  import IntentBasedNavigation from 'sap/fe/core/controllerextensions/IntentBasedNavigation';
  import MessageHandler from 'sap/fe/core/controllerextensions/MessageHandler';
  import Paginator from 'sap/fe/core/controllerextensions/Paginator';
  import Recommendations from 'sap/fe/core/controllerextensions/Recommendations';
  import Routing from 'sap/fe/core/controllerextensions/Routing';
  import Share from 'sap/fe/core/controllerextensions/Share';
  import ViewState from 'sap/fe/core/controllerextensions/ViewState';
  import CoreElement from 'sap/ui/core/Element';

  export default class ControllerExtension<ExtensionAPI> {
    base: {
      getExtensionAPI(): ExtensionAPI;
      getView(): View;
      getAppComponent(): AppComponent;
      byId(id: string): CoreElement
    };
  }

  export type Overrides<GenericController extends Controller = Controller> = {
    editFlow?: Partial<EditFlow>;
    intentBasedNavigation?: Partial<IntentBasedNavigation>;
    messageHandler?: Partial<MessageHandler>;
    paginator?: Partial<Paginator>;
    recommendations?: Partial<Recommendations>;
    routing?: Partial<Routing>;
    share?: Partial<Share>;
    viewState?: Partial<ViewState>;
  } & Partial<GenericController>;
}

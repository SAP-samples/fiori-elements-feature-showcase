import PageController from 'sap/fe/core/PageController';
import { Button$PressEvent } from 'sap/m/Button';
import Graph from 'sap/suite/ui/commons/networkgraph/Graph';
import Node from 'sap/suite/ui/commons/networkgraph/Node';
import ComparisonMicroChart from 'sap/suite/ui/microchart/ComparisonMicroChart';
import ComparisonMicroChartData from 'sap/suite/ui/microchart/ComparisonMicroChartData';
import JSONModel from 'sap/ui/model/json/JSONModel';

/**
 * @namespace sap.fe.showcase.lrop.ext.controller
 * @controller
 */
export default class CustomObjectPage extends PageController {
	private _modelSettings: JSONModel
  onInit () {
			PageController.prototype.onInit.apply(this);

			const model = new JSONModel(sap.ui.require.toUrl("sap/fe/showcase/lrop/ext/controller/data.json"));

			this.getView()?.setModel(model, 'graph');

			this._modelSettings = new JSONModel({
				source: "atomicCircle",
				orientation: "LeftRight",
				arrowPosition: "End",
				arrowOrientation: "ParentOf",
				nodeSpacing: 55,
				mergeEdges: false
			});

			this.getView()?.setModel(this._modelSettings, "settings");

			const fnSetContent = function (node: Node) {
				node.setContent(new ComparisonMicroChart({
					size: "M",
					scale: "M",
					data: [
						new ComparisonMicroChartData({
							title: "USA",
							value: Math.floor(Math.random() * 60),
							color: "Neutral"
						}),
						new ComparisonMicroChartData({
							title: "EMEA",
							value: Math.floor(Math.random() * 60),
							color: "Error"
						}),
						new ComparisonMicroChartData({
							title: "APAC",
							value: -20,
							color: "Good"
						}),
						new ComparisonMicroChartData({
							title: "LTA",
							value: Math.floor(Math.random() * 60) * -1,
							color: "Critical"
						}),
						new ComparisonMicroChartData({
							title: "ALPS",
							value: Math.floor(Math.random() * 20),
							color: "Good"
						})
					]
				}).addStyleClass("sapUiSmallMargin"));

			};

			model.attachRequestCompleted(() => {
				(this.byId("graph") as Graph).getNodes().forEach(function (node) {
					if (node.getKey() === "21" || node.getKey() === "18") {
						fnSetContent(node);
					}
				});
			});
		}
		onAfterRendering () {
			this.byId("graphWrapper")?.$().css("overflow-y", "auto");
		}
		mergeChanged (oEvent: Button$PressEvent) {
			this._modelSettings.setProperty("/mergeEdges", !!Number(oEvent.getSource().getProperty("selectedKey")));
		}
		spacingChanged (oEvent: Button$PressEvent) {
			this._modelSettings.setProperty("/nodeSpacing", Number(oEvent.getSource().getProperty("selectedKey")));
		}
}
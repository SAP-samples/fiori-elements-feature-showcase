sap.ui.define([
	"sap/ui/core/library"
], function(coreLibrary) {
    "use strict";

    return {
		//Search-Term: #EditFlowAPI
		onChangeCriticality: function(oEvent) {
			let sActionName = "service1.changeCriticality";
			let mParameters = {
				contexts: oEvent.getSource().getBindingContext(),
				model: oEvent.getSource().getModel(),
				label: 'Confirm',	
				invocationGrouping: true 	
			};
			this.editFlow.invokeAction(sActionName, mParameters); //SAP Fiori elements EditFlow API
		},

		//Function for Micro Process Flow in Custom Column
        itemPressColumn: function(oEvent) {
            const oPopover = itemPress(oEvent);
			const thisHelp = this;
			const closeSideContent = function() {
				thisHelp.showSideContent("childEntities1Section",false);
			};

			oPopover.attachBeforeClose(closeSideContent);
			this.showSideContent("childEntities1Section",true);
			oPopover.openBy(oEvent.getParameter("item"));
        },
		//Function for Micro Process Flow in Custom Header Facet
        itemPressHeader: function(oEvent) {
            const oPopover = itemPress(oEvent);
			oPopover.openBy(oEvent.getParameter("item"));
        }
    };

	function itemPress(oEvent) {
		const oItem = oEvent.getSource(),
			aCustomData = oItem.getCustomData(),
			sTitle = aCustomData[0].getValue(),
			sIcon = aCustomData[1].getValue(),
			sSubTitle = aCustomData[2].getValue(),
			sDescription = aCustomData[3].getValue();
		
		let colorState;
		switch (oItem.getState()) {
			case "Error" : colorState= coreLibrary.IconColor.Negative; break;
			case "Warning" : colorState= coreLibrary.IconColor.Critical; break;
			case "Success" : colorState= coreLibrary.IconColor.Positive; break;
		}
		const oPopover = new sap.m.Popover({
			contentWidth: "300px",
			title: "Order status",
			content: [
				new sap.m.HBox({
					items: [
						new sap.ui.core.Icon({
							src: sIcon,
							color: colorState
						}).addStyleClass("sapUiSmallMarginBegin sapUiSmallMarginEnd"),
						new sap.m.FlexBox({
							width: "100%",
							renderType: "Bare",
							direction: "Column",
							items: [new sap.m.Title({
								level: sap.ui.core.TitleLevel.H1,
								text: sTitle
							}), new sap.m.Text({
								text: sSubTitle
							}).addStyleClass("sapUiSmallMarginBottom sapUiSmallMarginTop"),
								new sap.m.Text({
									text: sDescription
								})
							]
						})
					]
				}).addStyleClass("sapUiTinyMargin")
			],
			footer: [
				new sap.m.Toolbar({
					content: [
						new sap.m.ToolbarSpacer(),
						new sap.m.Button({
							text: "Close",
							press: function() {
								oPopover.close();
							}
						})]
				})
			]
		});
		return oPopover;
	}
});
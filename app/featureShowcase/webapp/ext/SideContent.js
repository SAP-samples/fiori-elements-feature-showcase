sap.ui.define([], function() {
   "use strict";
   //Search-Term: #SideContent
   return {
      toggleSideContent: function(oBindingContext) {
         this.showSideContent("customSectionQualifier");
      },
      toggleSideContentItem1: function(oContextInfo) {
         this.showSideContent("childEntities1Section");
      }
   };
});
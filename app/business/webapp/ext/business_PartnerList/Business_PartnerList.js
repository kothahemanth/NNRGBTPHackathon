sap.ui.define([
    "sap/m/MessageToast"
], function(MessageToast) {
    'use strict';

    return {
        isVendor: function(oBindingContext,aSelectedContexts) {       
            aSelectedContexts.forEach(element => {
               MessageToast.show(element.sPath);
               var aData = jQuery.ajax({
                   type: "PATCH",
                   contentType: "application/json",
                   url: "/odata/v4/nnrg/"+element.sPath,
                   data: JSON.stringify({Is_vendor:true})
               }).then(element.requestRefresh());
           });
       }, 
       isNotVendor: function(oBindingContext,aSelectedContexts) {       
        aSelectedContexts.forEach(element => {
           MessageToast.show(element.sPath);
           var aData = jQuery.ajax({
               type: "PATCH",
               contentType: "application/json",
               url: "/odata/v4/nnrg/"+element.sPath,
               data: JSON.stringify({Is_vendor:false})
           }).then(element.requestRefresh());
       });
    }, 
    }
}
)
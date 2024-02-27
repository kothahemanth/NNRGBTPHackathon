sap.ui.define([
    "sap/m/MessageToast"
], function(MessageToast) {
    'use strict';

    return {
        isCustomer: function(oBindingContext,aSelectedContexts) {       
            aSelectedContexts.forEach(element => {
               var aData = jQuery.ajax({
                   type: "PATCH",
                   contentType: "application/json",
                   url: "/odata/v4/nnrg"+element.sPath,
                   data: JSON.stringify({Is_customer:true})
               }).then(element.requestRefresh());
           });
       },    
       isNotCust: function(oBindingContext,aSelectedContexts) {       
        aSelectedContexts.forEach(element => {
           var aData = jQuery.ajax({
               type: "PATCH",
               contentType: "application/json",
               url: "/odata/v4/nnrg"+element.sPath,
               data: JSON.stringify({Is_customer:false})
           }).then(element.requestRefresh());
       });
    }
    }
}
)
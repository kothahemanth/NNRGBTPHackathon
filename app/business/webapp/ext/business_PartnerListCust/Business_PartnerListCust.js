sap.ui.define([
    "sap/m/MessageToast"
], function(MessageToast) {
    'use strict';
    return {
        isCustomer: function(oBindingContext,aSelectedContexts) {       
             aSelectedContexts.forEach(element => {
                MessageToast.show(element.sPath);
                var aData = jQuery.ajax({
                    type: "PATCH",
                    contentType: "application/json",
                    url: "/odata/v4/student-db"+element.sPath,
                    data: JSON.stringify({Is_customer:true})
                }).then(element.requestRefresh());
            });
        },    
    }
});
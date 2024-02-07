sap.ui.define([
    "sap/m/MessageToast"
], function(MessageToast) {
    'use strict';

    return {
        SetAlumni: function(oBindingContext,aSelectedContexts) {       
             aSelectedContexts.forEach(element => {
                MessageToast.show(element.sPath);
                var aData = jQuery.ajax({
                    type: "PATCH",
                    contentType: "application/json",
                    url: "/odata/v4/nnrg"+element.sPath,
                    data: JSON.stringify({is_customer:true})
                }).then(element.requestRefresh());
            });
        },
        SetStudent: function(oBindingContext,aSelectedContexts) {       
            aSelectedContexts.forEach(element => {
               MessageToast.show(element.sPath);
               var aData = jQuery.ajax({
                   type: "PATCH",
                   contentType: "application/json",
                   url: "/odata/v4/nnrg"+element.sPath,
                   data: JSON.stringify({is_customer:false})
               }).then(element.requestRefresh());
           });
       }
    }
}
)
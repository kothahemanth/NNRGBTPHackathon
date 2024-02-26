sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'business',
            componentId: 'Business_PartnerList',
            contextPath: '/Business_Partner'
        },
        CustomPageDefinitions
    );
});
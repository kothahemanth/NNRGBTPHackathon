sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'business/test/integration/FirstJourney',
		'business/test/integration/pages/BusinessList',
		'business/test/integration/pages/BusinessObjectPage'
    ],
    function(JourneyRunner, opaJourney, BusinessList, BusinessObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('business') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheBusinessList: BusinessList,
					onTheBusinessObjectPage: BusinessObjectPage
                }
            },
            opaJourney.run
        );
    }
);
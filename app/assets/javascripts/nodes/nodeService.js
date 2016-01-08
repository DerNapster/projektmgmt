(function(){
	'use strict';

	angular.module('nodes')
	.service('nodeService', ['$q', NodeService]);

/**
 *    * Users DataService
 *       * Uses embedded, hard-coded data model; acts asynchronously to simulate
 *          * remote data service call(s).
 *             *
 *                * @returns {{loadAll: Function}}
 *                   * @constructor
 *                      */
	function NodeService($q){
		var breakdownStructurs = [
			{
				name: 'Product',
				description: 'This is the product breakdown structur (PBS), you may plan your product here',
				component: [
					{ id: '1',
					  desc: 'Webshop',
					  component: [
					  	{
							id: '2',
							desc: 'Warenkorb'
						}
					  ]
					}
				]
			},
			{
				name: 'Work',
				description: 'This is the work breakdown structur (WBS), you may plan your work here'
			},
			{
				name: 'Resource',
				description: 'This is the resource breakdown structur (RBS), you may plan your resources here'
			},
			{
				name: 'Resource Allocation Matrix',
				description: 'This is the resource allocation matrix (RAM), you may asign your resources to the work here'
			}
		];

		// Promise-based API
		return {
		 	loadlAllBreakdownStructurs :function() {
					    // Simulate async nature of real remote calls
					    return $q.when(breakdownStructurs);
				    }
		};
	}

})();

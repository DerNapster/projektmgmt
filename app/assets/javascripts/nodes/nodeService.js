
	'use strict';

	angular.module('nodes')
	.service('NodeService', ['$http', NodeService]);

/**
* Users DataService
* Uses embedded, hard-coded data model; acts asynchronously to simulate
* remote data service call(s).
*
* @returns {{loadAll: Function}}
* @constructor
*/
	function NodeService($http){

		this.getData = function() {
        var promise = $http.get('nodes.json');
        promise = promise.then(function (response) {
            return response.data;
        });

				console.log(promise);
        return promise;
    };

	}

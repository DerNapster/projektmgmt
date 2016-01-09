	'use strict';

	angular.module('nodes')
		.controller('NodeController', ['NodeService', '$mdSidenav', '$log', '$q', NodeController]);

	/**
	* Main Controller for the Angular Material Starter App
	* @param $scope
	* @param $mdSidenav
	* @param avatarsService
	* @constructor
	*/
	function NodeController( NodeService, $mdSidenav, $log, $q) {
		var self = this;

		self.name = "Product Breakdown Strcutur";
		self.description = "Product breakdown structure (PBS) is a tool for analysing, documenting and communicating the outcomes of a project, and forms part of the product based planning technique."

		self.breakdownStructurs        = [ ];
		self.toggleList   = toggleNavigation;

		// Load all structurs
		NodeService
			.getData()
			.then( function ( breakdownStructurs ) {
				self.breakdownStructurs = [].concat(breakdownStructurs);
				console.log(self.breakdownStructurs);
			});

			//
			// Internal methods
			//
			/**
			 * Hide or show sideNav area
			 */
			function toggleNavigation () {
				var pending = $q.when(true);

				pending.then(function() {
					$mdSidenav('left').toggle();
				});
			}

			function getPbs() {

			}

			function getWbs() {

			}

			function getRam() {

			}

	}

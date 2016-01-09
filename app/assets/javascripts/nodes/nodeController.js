(function(){

	angular
	.module('nodes')
	.controller('NodeController', [
		'nodeService', '$mdSidenav', '$mdBottomSheet', '$log', '$q',
		NodeController
		]);

/**
 *    * Main Controller for the Angular Material Starter App
 *       * @param $scope
 *          * @param $mdSidenav
 *             * @param avatarsService
 *                * @constructor
 *                   */
function NodeController( breakdownStructurService, $mdSidenav, $mdBottomSheet, $log, $q) {
	var self = this;

	self.selected     = null;
	self.breakdownStructurs        = [ ];
	self.selectBreakdownStructur   = selectBreakdownStructur;
	self.toggleList   = toggleBreakdownStructurList;
	self.showEditOptions  = showEditOptions;

	// Load all structurs

	breakdownStructurService
		.loadlAllBreakdownStructurs()
		.then( function ( breakdownStructurs ) {
			self.breakdownStructurs = [].concat(breakdownStructurs);
			self.selected = breakdownStructurs[0];
		});

		//
		// Internal methods
		//

		/**
		 * Hide edit menu if visible, then hide or show sideNav area
		 */
		function toggleBreakdownStructurList () {
			var pending = $mdBottomSheet.hide() || $q.when(true);

			pending.then(function() {
				$mdSidenav('left').toggle();
			});
		}

		/**
		 * Select the current breakdownStructur
		 */
		function selectBreakdownStructur( breakdownStructur ) {
			self.selected = angular.isNumber(breakdownStructur) ? $scope.breakdownStructurs[breakdownStructur] : breakdownStructur;
			self.toggleList();
		}


		/**
		 * Show the edit menu
		 */
		function showEditOptions($event) {
			var breakdownStructur = self.selected;

			return $mdBottomSheet.show({
				parent: angular.element(document.getElementById('edit')),
			       templateUrl: './src/breakdownStructurs/view/editMenu.html',
			       controller: ['$mdBottomSheet', EditPanelController],
				controllerAs: "ep",
			       bindToController: true,
			       targetEvent: $event
			}).then(function(clickedItem){
				clickedItem && log.debug(clickedItem.name + ' clicked!');
			});

			/**
			 * Bottom Sheet controller for edit actions
			 */
			function EditPanelController ( $mdBottomSheet ) {
				this.breakdownStructur = breakdownStructur;
				this.actions = [
				{ name: 'Umbenennen', icon: 'label' }
				];
				this.submitEdit = function ( action ) {
					$mdBottomSheet.hide(action);
				};
			}
		}
	}
})();

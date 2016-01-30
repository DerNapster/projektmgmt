(function() {
  'use strict';
  var fab = angular.module('app.fab', ['ngMaterial']);

  fab.controller('fabController', function($routeParams, $location, $log) {

      this.topDirections = ['left', 'up'];
      this.bottomDirections = ['down', 'right'];
      this.isOpen = false;
      this.availableModes = ['md-fling', 'md-scale'];
      this.selectedMode = 'md-scale';
      this.availableDirections = ['up', 'down', 'left', 'right'];
      this.selectedDirection = 'left';

      this.isVisible = function () {
        var bool = ($routeParams.project_id === undefined ? false : true);
        return bool;
      }

      this.pbs = function () {
        changeLocation('nodes');
      }

      this.rbs = function () {
        changeLocation('roles');
      }

      this.wbs = function () {
        changeLocation('works');
      }

      this.ram = function () {
        changeLocation('rams');
      }

      this.delphi = function () {
        changeLocation('delphis');
      }

      function changeLocation( link ) {
        $log.debug('changeLocation');
        $location.path($routeParams.project_id + "/" + link);
      }


    });
})();

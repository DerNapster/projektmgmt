
"use strict";

(function(){

  var controle = angular.module('app.controle', ['ngMaterial'] );

  controle.config( function() {

  });


  controle.run ( function (){
  });


  controle.controller ('controleController', function($scope, $timeout, $mdSidenav, $mdComponentRegistry, $log) {

    // Option #1
    //
    // $scope.isOpen = function() { return $mdSidenav('right').isOpen(); };
    // $scope.toggle = function() { $mdSidenav('right').toggle() };


    // Option #2 - See https://github.com/angular/material/issues/974
    $scope.toggle = angular.noop;
    $scope.isOpen = function() { return false };

    $mdComponentRegistry
      .when('right')
      .then( function(sideNav){

        $scope.isOpen = angular.bind( sideNav, sideNav.isOpen );
        $scope.toggle = angular.bind( sideNav, sideNav.toggle );

      });

    $scope.toggleLeft = function() {
      $mdSidenav('left').toggle()
                        .then(function(){
                            $log.debug("toggle left is done");
                        });
    };

    $scope.close = function() {
      $mdSidenav('left').close()
                        .then(function(){
                          $log.debug("close LEFT is done");
                        });
    };
  })

})();

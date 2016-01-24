"use strict";

(function() {


  var ram = angular.module('app.rams', []);

  ram.config( function ($httpProvider) {
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
  });

  ram.run ( function () {});

  ram.controller('ramController', function ($scope, $log, $rams, ramService, $routeParams) {

    var project_id = $routeParams.project_id;

    $scope.refresh = function () {
      $scope.getRams = $rams.getRams( { project_id:project_id} );
    };

    $scope.rams = $rams.getRams( { project_id:project_id} );

    $scope.updateRam = function ( ev, ram ) {
      $log.debug( ram );
      ram.$updateRam ( function ( data ) {
        $log.debug ( data );
        // refresh nodes
        $scope.rams = $scope.refresh();
      });
    }

    $scope.loadWorkpackages = function ( ) {
      ramService.getWorkpackages( project_id )
        .then( function ( data ) {
          $log.debug( data );
          $scope.workpackages = data.data;
        });
    };


    $scope.loadRoles = function ( ) {
          ramService.getRoles( project_id )
            .then( function ( data ) {
              $log.debug( data );
              $scope.roles = data.data;
            });
    };

  });

  ram.provider('$rams', function () {
    var endpoint = '/ram.json';

    this.setEndpoint = function ( url ) {
      endpoint = url;
    };

    this.$get = function ( $resource ) {

      return $resource (
        "/:project_id" + endpoint,
        {
          node_id:'@id'
        },
        {
         'getRam': {method:'GET'},
         'createRam': {method:'POST'},
         'getRams': {method:'GET', isArray:true},
         'deleteRam': {method: 'DELETE' },
         'updateRam': {method: 'PUT', responseType: 'text'} //Rest delivers text not object (succes message)
        }
      );
    }
  });


  ram.provider('ramService', function () {
    var endpoint = '/ram';

    this.$get = function ($http, $log, $q) {
      return {

        getNodes : function ( id ) {

          var promise = $http.get("/" + id + endpoint + ".json")
          .success(function (data) {
            $log.debug(data);
          })
          .error(function (data) {
            $log.debug(data);
          });

          return promise;
        },

        getWorkpackages : function ( id ) {

          var promise = $http.get("/" + id + endpoint + "/wbs.json")
          .success(function (data) {
            $log.debug(data);
          })
          .error(function (data) {
            $log.debug(data);
          });

          return promise;
        },

        getRoles : function ( id ) {

          var promise = $http.get("/" + id + endpoint + "/rbs.json")
          .success(function (data) {
            $log.debug(data);
          })
          .error(function (data) {
            $log.debug(data);
          });

          return promise;
        }
      }
    }
  });

})();

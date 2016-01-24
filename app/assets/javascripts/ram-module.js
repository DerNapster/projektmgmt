"use strict";

(function() {


  var ram = angular.module('app.rams', []);

  ram.config( function ($httpProvider) {
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
  });

  ram.run ( function () {});

  ram.controller('ramController', function ($scope, $log, ramService, $routeParams) {

    var project_id = $routeParams.project_id;

    ramService.get( project_id )
      .then(function (data) {
        $log.debug(data);
        $scope.rams = data.data;
      });
  });


  ram.provider('ramService', function () {
    var endpoint = '/ram.json';

    this.$get = function ($http, $log, $q) {
      return {

        get : function ( id ) {

          var promise = $http.get("/" + id + endpoint)
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

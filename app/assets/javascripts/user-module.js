"use strict";

(function() {

  var users = angular.module( "app.users", [] );

  users.run( function() {});

  users.config( function() {})

  users.controller( "usersController", function($users, $log, $scope, $routeParams) {

        var project_id = $routeParams.project_id;

        // usersGraph.get( project_id )
        //   .then(function (data) {
        //     $log.debug(data);
        //     $scope.chartData = data.data;
        //   });


        /*
        * GET /users.json
        * @return Users List
        */
        $scope.users = $users.getUsers( { project_id:project_id } ) ;

        $scope.refresh = function () {
          return $users.getUsers( { project_id:project_id } );
        };

        /*
         * PUT /users
         * @param User Object
         * @return updated User
         */
        $scope.updateUser = function ( user ) {
          $log.debug(user);
          user.$updateUser ( function ( data ) {
            $log.debug ( data );
          });
        };
  });

  users.provider ( "$users", function() {
    var endpoint = '/users';

    this.setEndpoint = function ( url ) {
      endpoint = url;
    };

    this.$get = function ( $resource ) {

      return $resource (
        "/:project_id" + endpoint + "/:user_id" + ".json",
        {
          user_id:'@id',
          project_id:'@sub_id'
        },
        {
         'getUser': {method:'GET'},
         'createUser': {method:'POST'},
         'getUsers': {method:'GET', isArray:true},
         'deleteUser': {method: 'DELETE' },
         'updateUser': {method: 'PUT', responseType: 'text'} //Rest delivers text not object (succes message)
        }
      );
    }
  });



})();

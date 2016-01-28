"use strict";

(function() {

  var users = angular.module( "app.users", [] );

  users.run( function() {});

  users.config( function() {})

  users.controller( "usersController", function($users, $log, $scope, $routeParams, $mdDialog) {

        var project_id = $routeParams.project_id;

        /*
        * GET /users.json
        * @return Users List
        */
        $scope.users = $users.getUsers( { project_id:project_id } ) ;

        $scope.refresh = function () {
          return $users.getUsers( { project_id:project_id } );
        };

        /*
         * DELETE /users/{id}.json
         * @param id of node
         */
        $scope.deleteUser = function ( user ) {
          $users.deleteUser ( { project_id:project_id, user_name:user }, function ( data ) {
            $log.debug ( data );
            // refresh nodes
            $scope.users = $scope.refresh();
          });
        };

        $scope.deleteUserDialog = function(ev, user) {
            // Appending dialog to document.body to cover sidenav in docs app
            var confirm = $mdDialog.confirm()
                  .title('Wollen Sie wirklich den User "' + user + '" löschen?')
                  .textContent('Es werden alle Delphi eingaben des Users gelöscht')
                  .targetEvent(ev)
                  .cancel('Abbrechen')
                  .ok('Löschen')

            $mdDialog.show(confirm).then(function( ) {
              $scope.deleteUser ( user );
              $scope.message = 'User gelöscht';
            }, function() {
              $scope.message = 'User behalten';
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
        "/:project_id" + endpoint + "/:user_name" + ".json",
        {
          user_name:'@uname',
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

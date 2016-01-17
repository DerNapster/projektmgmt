"use strict";

(function(){

  var roles = angular.module('app.roles', ['ngResource', 'ngRoute'] );

  roles.config( function($routeProvider, $httpProvider, $rolesProvider) {
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
  });


  roles.run ( function ($roles, $log, $routeParams){

    $log.debug($roles.getRoles());

    $log.debug($roles.getRole({role_id:1}));

    $log.debug($routeParams);
  });


  ///
  /// Datalogic
  /// Provides Methods to consume the REST API
  ///
  roles.controller ('rolesController', function ($scope, $roles, $log, $mdDialog, $mdMedia, $routeParams, $rootScope) {

    $scope.parent;

    var project_id = $routeParams.project_id;

    /*
    * GET /roles.json
    * @return Roles List
    */
    $scope.roles = $roles.getRoles( { project_id:project_id } ) ;

    /*
     * GET /roles/{id}.json
     * @return Role
     */
    $scope.getRole = function ( id ) {
      $roles.getRole( { role_id:id } );
    };

    /*
     * POST /roles
     * @param name, description, level, duration, startdate, enddate, milestone, pbstable_id, parent_id
     * @return created Role
     */
    $scope.newRole = function ( name, description ) {
      // $roles.save(
      $roles.createRole(
        {
          name: name,
          description: description,
          project_id: project_id
        }, function ( data )
        {
          $log.debug ( data );

          if (data.status == 500 ) {
            $log.debug( '500');
          }

          // refresh roles
          $scope.roles = $roles.getRoles();
        }
      );
    };

    /*
     * PUT /roles
     * @param Role Object
     * @return updated Role
     */
    $scope.updateRole = function ( role ) {
      $log.debug(role);
      role.$updateRole ( function ( data ) {
        $log.debug ( data );
        // refresh roles
        $scope.roles = $roles.getRoles();
      });
    };

    /*
     * DELETE /roles/{id}.json
     * @param id of role
     */
    $scope.deleteRoleById = function ( id ) {
      $roles.deleteRole ( { role_id:id }, function ( data ) {
        $log.debug ( data );
        // refresh roles
        $scope.roles = $roles.getRoles();
      });
    };

    /*
     * DELETE /roles/{id}.json
     * @param role
     */
    $scope.deleteRole = function ( role ) {
      $roles.remove ( function ( data ) {
        $log.debug ( data );
        // refresh roles
        $scope.roles = $roles.getRoles();
      });
    };

    $scope.addRoleDialog = function(ev, role, roles) {

      if(role) {
        $scope.parent = role.id;
      }

      var useFullScreen = ($mdMedia('sm') || $mdMedia('xs'))  && $scope.customFullscreen;
      $mdDialog.show({
        controller: RoleDialogController,
        templateUrl: 'newRole.html',
        parent: angular.element(document.body),
        targetEvent: ev,
        locals: {
          role: role,
          roles: roles
        },
        clickOutsideToClose:true,
        fullscreen: useFullScreen
      })
      .then(function(answer) {
        // $scope.status = 'You said the information was "' + answer + '".';
        $log.debug(answer);

        if (answer.parent_id) {
            $scope.newRole ( answer.name, project_id, answer.parent  )
        } else {
            $scope.newRole ( answer.name, project_id, $scope.parent  )
            $scope.parent = "";
        }



      }, function() {
        $scope.status = 'You cancelled the dialog.';
        $scope.parent = "";
      });
      $scope.$watch(function() {
        return $mdMedia('xs') || $mdMedia('sm');
      }, function(wantsFullScreen) {
        $scope.customFullscreen = (wantsFullScreen === true);
      });

    };

    $scope.deleteRoleDialog = function(ev, role) {
        // Appending dialog to document.body to cover sidenav in docs app
        var confirm = $mdDialog.confirm()
              .title('Wollen Sie wirklich den Knoten ' + role.name + ' löschen?')
              .textContent('Es werden alle Kind Elemente des Knoten gelöscht')
              .targetEvent(ev)
              .cancel('Abbrechen')
              .ok('Löschen')

        $mdDialog.show(confirm).then(function( ) {
          $scope.deleteRoleById( role.id );
          $scope.message = 'Knoten gelöscht';
        }, function() {
          $scope.message = 'Knoten behalten';
        });
      };

  });

  ///
  /// REST API
  /// Provides GET, POST, DELETE, PUT Methods
  /// use getRole, getRoles, createRole, deleteRole, updateRole
  ///
  roles.provider('$roles', function (  ) {
      var endpoint = '/roles';

      this.setEndpoint = function ( url ) {
        endpoint = url;
      };

      this.$get = function ( $resource ) {

        return $resource (
          "/:project_id" + endpoint + "/:role_id" + ".json",
          {
            role_id:'@id',
            project_id:'@sub_id'
          },
          {
           'getRole': {method:'GET'},
           'createRole': {method:'POST'},
           'getRoles': {method:'GET', isArray:true},
           'deleteRole': {method: 'DELETE' },
           'updateRole': {method: 'PUT', responseType: 'text'} //Rest delivers text not object (succes message)
          }
        );
      }
  });

  function RoleDialogController($scope, $mdDialog, role, roles) {
    $scope.role = role;
    $scope.roles = roles;

    $scope.cancel = function() {
      $mdDialog.cancel();
    };
    $scope.answer = function( answer ) {
      $mdDialog.hide(answer);
    };
  }


})();

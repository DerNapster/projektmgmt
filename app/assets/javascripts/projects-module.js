"use strict";

(function(){

  var projects = angular.module('app.projects', ['ngResource'] );

  projects.config( function($httpProvider) {
    $httpProvider.defaults.headers.common['X-CSRF-Token'] =
      $('meta[name=csrf-token]').attr('content');
  });


  projects.run ( function (projectService, $log){
    $log.debug('app.projects', projectService.getProjects());

  });

  projects.controller('projectsController', function ($scope, projectService, projectsGraph, $log, $mdDialog, $mdMedia, $rootScope, $routeParams) {

        /*
        * GET /nodes.json
        * @return Nodes List
        */
        $scope.projects = projectService.getProjects();

        var project_id = $routeParams.project_id;

        $scope.startDate = new Date();

        /* projectsGraph.get( project_id, $scope.startDate.year, $scope.startDate.month, $scope.startDate.day )
          .then(function (data) {
            $log.debug(data);
            $scope.chartData = data.data;
          });*/

        $scope.getChartData = function () {
          projectsGraph.get( project_id, $scope.startDate.getFullYear(), $scope.startDate.getMont(), $scope.startDate.getDay() )
            .then(function (data) {
              $log.debug(data);
              $scope.chartData = data.data;
            });
        }

        $scope.selectedProject = projectService.getProject(  { project_id:$routeParams.project_id } );

        $scope.refresh = function () {
          return $scope.getProjects( );
        };

        /*
         * GET /nodes/{id}.json
         * @return Node
         */
        $scope.getProject = projectService.getProject( { project_id:$routeParams.project_id } );

        /*
         * POST /nodes
         * @param newproject
         * @return created Node
         */
        $scope.newProject = function ( newproject ) {

          projectService.createProject(
            {
              name: newproject.name,
              description: newproject.description
            }, function ( data )
            {
              $log.debug ( data );

              if (data.status == 500 ) {
                $log.debug( '500');
              }

              // refresh works
              $scope.projects = $scope.refresh();
            }
          );
        };

        /*
         * PUT /nodes
         * @param Node Object
         * @return updated Node
         */
        $scope.updateProject = function ( project ) {
          $log.debug(project);
          project.$updateProject ( function ( data ) {
            $log.debug ( data );
            // refresh nodes
            $scope.projects = $scope.refresh();
          });
        };

        /*
         * DELETE /nodes/{id}.json
         * @param id of node
         */
        $scope.deleteProjectById = function ( id ) {
          projectService.deleteProject ( { project_id:id }, function ( data ) {
            $log.debug ( data );
            // refresh nodes
            $scope.projects = $scope.refresh();
          });
        };

        /*
         * DELETE /nodes/{id}.json
         * @param node
         */
        $scope.deleteProject = function ( project ) {
          $nodes.remove ( function ( data ) {
            $log.debug ( data );
            // refresh nodes
            $scope.projects = $scope.refresh();
          });
        };


      $scope.addProjectDialog = function(ev) {

        var useFullScreen = ($mdMedia('sm') || $mdMedia('xs'))  && $scope.customFullscreen;
        $mdDialog.show({
          controller: ProjectDialogController,
          templateUrl: 'newProject.html',
          parent: angular.element(document.body),
          targetEvent: ev,
          clickOutsideToClose:true,
          fullscreen: useFullScreen
        })
        .then(function(answer) {
          $scope.status = 'You said the information was "' + answer + '".';
          $log.debug(answer);
          $scope.newProject ( answer.name, answer.description );
        }, function() {
          $scope.status = 'You cancelled the dialog.';
        });
        $scope.$watch(function() {
          return $mdMedia('xs') || $mdMedia('sm');
        }, function(wantsFullScreen) {
          $scope.customFullscreen = (wantsFullScreen === true);
        });

      };

      $scope.deleteProjectDialog = function(ev, project) {
          // Appending dialog to document.body to cover sidenav in docs app
          var confirm = $mdDialog.confirm()
                .title('Wollen Sie wirklich das Projekt "' + project.name + '" löschen?')
                .textContent('Es werden alle Abhängigkeiten gelöscht')
                .targetEvent(ev)
                .cancel('Abbrechen')
                .ok('Löschen')

          $mdDialog.show(confirm).then(function( ) {
            $scope.deleteProjectById( project.id );
            $scope.message = 'Knoten gelöscht';
          }, function() {
            $scope.message = 'Knoten behalten';
          });
        };


  });


  projects.provider('projectService', function () {
    var endpoint = '/projects';

    this.setEndpoint = function ( url ) {
      endpoint = url;
    };

    this.$get = function ( $resource ) {

      return $resource (
        endpoint + "/:project_id" + ".json",
        {
          project_id:'@id'
        },
        {
         'getProject': {method:'GET'},
         'createProject': {method:'POST'},
         'getProjects': {method:'GET', isArray:true},
         'deleteProject': {method: 'DELETE' },
         'updateProject': {method: 'PUT', responseType: 'text'} //Rest delivers text not object (succes message)
        }
      );
    }
  });

  projects.provider('projectsGraph', function () {
      var endpoint = 'gantt';

      this.$get = function ($http, $log, $q) {
        return {

          get : function ( id, year, month, day ) {

            var promise = $http.get( id + "/" + endpoint + "/" + year + "/" + month + "/" + day + ".json")
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

  function ProjectDialogController($scope, $mdDialog) {

    $scope.cancel = function() {
      $mdDialog.cancel();
    };

    $scope.answer = function( answer ) {
      $mdDialog.hide(answer);
    };
  }

})();

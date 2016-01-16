"use strict";

(function(){

  var projects = angular.module('app.projects', ['ngResource'] );

  projects.config( function($httpProvider) {
    $httpProvider.defaults.headers.common['X-CSRF-Token'] =
      $('meta[name=csrf-token]').attr('content');
  });


  projects.run ( function (projectService, $log){
    $log.debug(projectService.getProjects());

    $log.debug(projectService.getProject({project_id:1}));
  });

  projects.controller('projectsController', function ($scope, projectService, $log, $mdDialog, $mdMedia) {

        /*
        * GET /nodes.json
        * @return Nodes List
        */
        $scope.projects = projectService.getProjects();

        /*
         * GET /nodes/{id}.json
         * @return Node
         */
        $scope.getProject = function ( id ) {
          projectService.getProject( { project_id:id } );
        };

        /*
         * POST /nodes
         * @param name, description, level, duration, startdate, enddate, milestone, pbstable_id, parent_id
         * @return created Node
         */
        $scope.newProject = function ( ) {

          projectService.createProject(
            {

            }, function ( data )
            {
              $log.debug ( data );

              if (data.status == 500 ) {
                $log.debug( '500');
              }

              // refresh nodes
              $scope.projects = projectService.getProjects();
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
            $scope.projects = projectService.getProjects();
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
            $scope.projects = projectService.getProjects();
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
            $scope.projects = projectService.getProjects();
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
          node_id:'@id'
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

})();

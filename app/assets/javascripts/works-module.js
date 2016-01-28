"use strict";

(function(){

  var works = angular.module('app.works', ['ngResource', 'ngRoute'] );

  works.config( function($routeProvider, $httpProvider, $worksProvider) {
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
  });


  works.run ( function (){});


  ///
  /// Datalogic
  /// Provides Methods to consume the REST API
  ///
  works.controller ('worksController', function ($scope, $works, worksGraph, $log, $mdDialog, $mdMedia, $routeParams, $rootScope) {

    $scope.parent;

    var project_id = $routeParams.project_id;

    $scope.getGraphData = worksGraph.get( project_id )
      .then(function (data) {
        $scope.chartData = data.data;
      });


    /*
    * GET /works.json
    * @return Works List
    */
    $scope.works = $works.getWorks( { project_id:project_id } ) ;

    $scope.refresh = function () {

      worksGraph.get( project_id )
        .then(function (data) {
          $log.debug(data);
          $scope.chartData = data.data;
        });

      return $works.getWorks( { project_id:project_id } );
    };

    /*
     * GET /works/{id}.json
     * @return Work
     */
    $scope.getWork = function ( id ) {
      $works.getWork( { work_id:id } );
    };

    /*
     * POST /works
     * @param name, description, level, duration, startdate, enddate, milestone, pbstable_id, parent_id
     * @return created Work
     */
    $scope.newWork = function ( name, description, parent_id ) {
      // $works.save(
      $works.createWork(
        {
          name: name,
          description: description,
          project_id: project_id,
          parent_id: parent_id
        }, function ( data )
        {
          $log.debug ( data );

          if (data.status == 500 ) {
            $log.debug( '500');
          }

          // refresh works
          $scope.works = $scope.refresh();
        }
      );
    };

    /*
     * PUT /works
     * @param Work Object
     * @return updated Work
     */
    $scope.updateWork = function ( work ) {
      $log.debug(work);
      work.$updateWork ( function ( data ) {
        $log.debug ( data );
      });
    };

    /*
     * DELETE /works/{id}.json
     * @param id of work
     */
    $scope.deleteWorkById = function ( id ) {
      $works.deleteWork ( { work_id:id }, function ( data ) {
        $log.debug ( data );
        // refresh works
        $scope.works = $scope.refresh();
      });
    };

    /*
     * DELETE /works/{id}.json
     * @param work
     */
    $scope.deleteWork = function ( work ) {
      $works.remove ( function ( data ) {
        $log.debug ( data );
        // refresh works
        $scope.works = $scope.refresh();
      });
    };

    $scope.addWorkDialog = function(ev, work, works) {

      if(work) {
        $scope.parent = work.id;
      }

      var useFullScreen = ($mdMedia('sm') || $mdMedia('xs'))  && $scope.customFullscreen;
      $mdDialog.show({
        controller: WorkDialogController,
        templateUrl: 'newWork.html',
        parent: angular.element(document.body),
        targetEvent: ev,
        locals: {
          work: work,
          works: works
        },
        clickOutsideToClose:true,
        fullscreen: useFullScreen
      })
      .then(function(answer) {
        // $scope.status = 'You said the information was "' + answer + '".';
        $log.debug(answer);

        if (answer.parent_id) {
            $scope.newWork ( answer.name, project_id, answer.parent  )
        } else {
            $scope.newWork ( answer.name, project_id, $scope.parent  )
            $scope.parent = null;
        }



      }, function() {
        $scope.status = 'You cancelled the dialog.';
        $scope.parent = null;
      });
      $scope.$watch(function() {
        return $mdMedia('xs') || $mdMedia('sm');
      }, function(wantsFullScreen) {
        $scope.customFullscreen = (wantsFullScreen === true);
      });

    };

    $scope.deleteWorkDialog = function(ev, work) {
        // Appending dialog to document.body to cover sidenav in docs app
        var confirm = $mdDialog.confirm()
              .title('Wollen Sie wirklich den Knoten ' + work.name + ' löschen?')
              .textContent('Es werden alle Kind Elemente des Knoten gelöscht')
              .targetEvent(ev)
              .cancel('Abbrechen')
              .ok('Löschen')

        $mdDialog.show(confirm).then(function( ) {
          $scope.deleteWorkById( work.id );
          $scope.message = 'Knoten gelöscht';
        }, function() {
          $scope.message = 'Knoten behalten';
        });
      };

  });

  ///
  /// REST API
  /// Provides GET, POST, DELETE, PUT Methods
  /// use getWork, getWorks, createWork, deleteWork, updateWork
  ///
  works.provider('$works', function (  ) {
      var endpoint = '/workpackages';

      this.setEndpoint = function ( url ) {
        endpoint = url;
      };

      this.$get = function ( $resource ) {

        return $resource (
          "/:project_id" + endpoint + "/:work_id" + ".json",
          {
            work_id:'@id',
            project_id:'@sub_id'
          },
          {
           'getWork': {method:'GET'},
           'createWork': {method:'POST'},
           'getWorks': {method:'GET', isArray:true},
           'deleteWork': {method: 'DELETE' },
           'updateWork': {method: 'PUT', responseType: 'text'} //Rest delivers text not object (succes message)
          }
        );
      }
  });

  works.provider('worksGraph', function () {
      var endpoint = '/workpackages/graph.json';

      this.$get = function ($http, $log, $q) {
        return {

          get : function ( id ) {

            var promise = $http.get("/" + id + endpoint)
            .success(function (data) {
            })
            .error(function (data) {
            });

            return promise;

          }
        }
      }


  });


  function WorkDialogController($scope, $mdDialog, work, works) {
    $scope.work = work;
    $scope.works = works;

    $scope.cancel = function() {
      $mdDialog.cancel();
    };
    $scope.answer = function( answer ) {
      $mdDialog.hide(answer);
    };
  }


})();

"use strict";

(function(){

  var nodes = angular.module('app.nodes', ['ngResource', 'ngRoute', 'app.graph'] );

  nodes.config( function($routeProvider, $httpProvider, $nodesProvider) {
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
  });


  nodes.run ( function ($nodes, nodesGraph, $log, $routeParams){
    $log.debug('app.nodes');
    $log.debug($nodes.getNode({node_id:1}));
    $log.debug("nodes Graph");
    $log.debug(nodesGraph.get(1));
  });

  ///
  /// Datalogic
  /// Provides Methods to consume the REST API
  ///
  nodes.controller ('nodesController', function ($scope, $nodes, nodesGraph, $log, $mdDialog, $mdMedia, $routeParams, $rootScope, $q, $http) {

    $scope.parent;

    var project_id = $routeParams.project_id;


    nodesGraph.get( project_id )
      .then(function (data) {
        $log.debug(data);
        $scope.chartData = data.data;
      });

  /*  [
      ['Mike', ''],
      ['Jim', 'Mike'],
      ['Alice', 'Mike'],
      ['Bob', 'Jim'],
      ['Carol', 'Bob']
    ];*/

    /*
    * GET /nodes.json
    * @return Nodes List
    */
    $scope.nodes = $nodes.getNodes( { project_id:project_id } ) ;

    $scope.refresh = function () {
      return $nodes.getNodes( { project_id:project_id } );
    };

    /*
     * GET /nodes/{id}.json
     * @return Node
     */
    $scope.getNode = function ( id ) {
      $nodes.getNode( { node_id:id } );
    };

    /*
     * POST /nodes
     * @param name, description, level, duration, startdate, enddate, milestone, pbstable_id, parent_id
     * @return created Node
     */
    $scope.newNode = function ( name, description, milestone, parent_id, project_id ) {
      $log.debug(name, description, milestone, parent_id, project_id);

      // $nodes.save(
      $nodes.createNode(
        {
          name: name,
          description: description,
          milestone: milestone,
          project_id: project_id,
          parent_id: parent_id
        }, function ( data )
        {
          $log.debug ( data );

          if (data.status == 500 ) {
            $log.debug( '500');
          }
          // refresh nodes
          $scope.nodes = $scope.refresh();
        }
      );
    };

    /*
     * PUT /nodes
     * @param Node Object
     * @return updated Node
     */
    $scope.updateNode = function ( node ) {
      $log.debug(node);
      node.$updateNode ( function ( data ) {
        $log.debug ( data );

      });
    };

    /*
     * DELETE /nodes/{id}.json
     * @param id of node
     */
    $scope.deleteNodeById = function ( id ) {
      $nodes.deleteNode ( { node_id:id }, function ( data ) {
        $log.debug ( data );
        // refresh nodes
        $scope.nodes = $scope.refresh();
      });
    };

    /*
     * DELETE /nodes/{id}.json
     * @param node
     */
    $scope.deleteNode = function ( node ) {
      $nodes.remove ( function ( data ) {
        $log.debug ( data );
        // refresh nodes
        $scope.nodes = $scope.refresh();
      });
    };

    $scope.addNodeDialog = function(ev, node, nodes) {

      var _temp_parent_id = [];
      if ( node ) _temp_parent_id = node.id;


      var useFullScreen = ($mdMedia('sm') || $mdMedia('xs'))  && $scope.customFullscreen;
      $mdDialog.show({
        controller: NodeDialogController,
        templateUrl: 'newNode.html',
        parent: angular.element(document.body),
        targetEvent: ev,
        locals: {
          node: node,
          nodes: nodes
        },
        clickOutsideToClose:true,
        fullscreen: useFullScreen
      })
      .then(function(answer) {
        // $scope.status = 'You said the information was "' + answer + '".';
        $log.debug(answer);

        if (answer.parent_id) {
            $scope.newNode ( answer.name, answer.description, answer.milestone, answer.parent_id, project_id  )
        } else {
            $scope.newNode ( answer.name, answer.description, answer.milestone, _temp_parent_id, project_id  )
            _temp_parent_id = null;
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

    $scope.deleteNodeDialog = function(ev, node) {
        // Appending dialog to document.body to cover sidenav in docs app
        var confirm = $mdDialog.confirm()
              .title('Wollen Sie wirklich den Knoten ' + node.name + ' löschen?')
              .textContent('Es werden alle Kind Elemente des Knoten gelöscht')
              .targetEvent(ev)
              .cancel('Abbrechen')
              .ok('Löschen')

        $mdDialog.show(confirm).then(function( ) {
          $scope.deleteNodeById( node.id );
          $scope.message = 'Knoten gelöscht';
          $scope.refresh();
        }, function() {
          $scope.message = 'Knoten behalten';
        });
      };

  });

  ///
  /// REST API
  /// Provides GET, POST, DELETE, PUT Methods
  /// use getNode, getNodes, createNode, deleteNode, updateNode
  ///
  nodes.provider('$nodes', function (  ) {
      var endpoint = '/nodes';

      this.setEndpoint = function ( url ) {
        endpoint = url;
      };

      this.$get = function ( $resource ) {

        return $resource (
          "/:project_id" + endpoint + "/:node_id" + ".json",
          {
            node_id:'@id',
            project_id:'@sub_id'
          },
          {
           'getNode': {method:'GET'},
           'createNode': {method:'POST'},
           'getNodes': {method:'GET', isArray:true},
           'deleteNode': {method: 'DELETE' },
           'updateNode': {method: 'PUT', responseType: 'text'} //Rest delivers text not object (succes message)
          }
        );
      }
  });

  nodes.provider('nodesGraph', function () {
      var endpoint = '/nodes/graph.json';

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


  function NodeDialogController($scope, $mdDialog, node, nodes) {
    $scope.node = node;
    $scope.nodes = nodes;

    $scope.cancel = function() {
      $mdDialog.cancel();
    };
    $scope.answer = function( answer ) {
      $mdDialog.hide(answer);
    };
  }


})();

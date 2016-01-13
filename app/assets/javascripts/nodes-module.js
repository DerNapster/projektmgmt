"use strict";

(function(){

  var nodes = angular.module('app.nodes', ['ngResource'] );

  nodes.config( function($httpProvider) {
    $httpProvider.defaults.headers.common['X-CSRF-Token'] =
      $('meta[name=csrf-token]').attr('content');
  });


  nodes.run ( function ($nodes, $log){
    $log.debug($nodes.getNodes());


    $log.debug($nodes.getNode({node_id:1}));
  });


  ///
  /// Datalogic
  /// Provides Methods to consume the REST API
  ///
  nodes.controller ('nodesController', function ($scope, $nodes, $log, $mdToast, $mdDialog, $mdMedia) {

    $scope.pbstable = function () {
      $scope.pbstable = $scope.nodes[0].pbstable_id;
    };

    /*
    * GET /nodes.json
    * @return Nodes List
    */
    $scope.nodes = $nodes.getNodes();

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
    $scope.newNode = function ( name, description, level, duration, startdate, enddate, milestone, pbstable_id, parent_id ) {
      // $nodes.save(
      $nodes.createNode(
        {
          name: name,
          description: description,
          level: level,
          duration: duration,
          startdate: startdate,
          enddate: enddate,
          milestone: milestone,
          pbstable_id: pbstable_id,
          parent_id: parent_id
        }, function ( data )
        {
          $log.debug ( data );
          toasterControllerProvider.showSimpleToast ( data.name + 'erstellt!');
          // refresh nodes
          $scope.nodes = $nodes.getNodes();
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
        // refresh nodes
        $scope.nodes = $nodes.getNodes();
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
        $scope.nodes = $nodes.getNodes();
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
        $scope.nodes = $nodes.getNodes();
      });
    };

    $scope.addNodeDialog = function(ev, node) {
      var useFullScreen = ($mdMedia('sm') || $mdMedia('xs'))  && $scope.customFullscreen;
      $mdDialog.show({
        controller: DialogController,
        templateUrl: 'newNode.html',
        parent: angular.element(document.body),
        targetEvent: ev,
        clickOutsideToClose:true,
        fullscreen: useFullScreen
      })
      .then(function(answer) {
        $scope.status = 'You said the information was "' + answer + '".';
      }, function() {
        $scope.status = 'You cancelled the dialog.';
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
              .ok('Löschen')
              .cancel('Abbrechen')
        $mdDialog.show(confirm).then(function( ) {
          $scope.deleteNodeById( node.id );
          $scope.message = 'Knoten gelöscht';
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
  nodes.provider('$nodes', function () {
      var endpoint = '/nodes';

      this.setEndpoint = function ( url ) {
        endpoint = url;
      };

      this.$get = function ( $resource ) {

        return $resource (
          endpoint + "/:node_id" + ".json",
          {
            node_id:'@id'
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

  function DialogController($scope, $mdDialog) {
    $scope.hide = function() {
      $mdDialog.hide();
    };
    $scope.cancel = function() {
      $mdDialog.cancel();
    };
    $scope.answer = function( node ) {

      newNode( node );

      toasterControllerProvider.showSimpleToast ( node.name + 'erstellt!');


      $mdDialog.hide(answer);
    };
  }


})();

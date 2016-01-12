"use strict";

(function(){

  var nodes = angular.module('app.nodes', ['ngResource'] );

  nodes.config( function () {

  });

  nodes.run ( function ($nodes, $log){
    $log.debug($nodes.getNodes());


    $log.debug($nodes.getNode({node_id:1}));
  });


  ///
  /// Datalogic
  /// Provides Methods to consume the REST API
  ///
  nodes.controller ('nodesController', function ($scope, $nodes) {

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
    $scope.deletNodeById = function ( id ) {
      $nodes.deleteUser ( { node_id:id }, function ( data ) {
        $log.debug ( data );
        // refresh nodes
        $scope.nodes = $nodes.getNodes();
      });
    };

    /*
     * DELETE /nodes/{id}.json
     * @param node
     */
    $scope.deletNode = function ( user ) {
      $nodes.$remove ( function ( data ) {
        $log.debug ( data );
        // refresh nodes
        $scope.nodes = $nodes.getNodes();
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

})();

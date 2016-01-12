"use strict";

(function(){

  var nodes = angular.module('app.nodes', ['ngResource'] );

  nodes.config( function () {

  });

  nodes.run ( function ($nodes, $log){
    $log.debug($nodes.getNodes());
    $log.debug($nodes.getNode(1))
  });


  nodes.provider('$nodes', function () {
      var endpoint = '/nodes.json';

      this.setEndpoint = function ( url ) {
        endpoint = url;
      };

      this.$get = function ( $resource ) {

        return $resource (
          endpoint + "/:node_id",
          {
            node_id:'@id'
          },
          {
           'getNode': {method:'GET'},
           'createNode': {method:'POST'},
           'getNodes': {method:'GET', isArray:true},
           'deletNode': {method: 'DELETE' },
           'updateNode': {method: 'PUT', responseType: 'text'}
          }
        );
      }
  });

})();

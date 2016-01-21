"use strict";

(function () {

    var delphi = angular.module('app.delphis', []);


    delphi.config ( function($routeProvider, $httpProvider, $delphisProvider) {
      $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
    });

    delphi.run ( function () {});

    delphi.controller('delphiController', function ($scope, $delphis, deliphiEvaluation, $log, $routeParams) {

      var project_id = $routeParams.project_id;

      /*
       * Refreshes the object list
       */
      $scope.refresh = function () {
        return $delphis.getDelphis( { project_id:project_id, delphi_username:name } );
      };

      /*
       * GET /:project_id/delphis/evaulation
       * @return Evaluation der Delphi Methode
       */
       deliphiEvaluation.get( project_id )
         .then(function (data) {
           $log.debug(data);
           $scope.deliphiEvaluation = data.data;
         });

      /*
      * GET /delphis.json
      * @return Delphis List
      */
      $scope.getDelphis = function ( name ) {
        $scope.delphis = $delphis.getDelphis( { project_id:project_id, delphi_username:name } ) ;
      }

      /*
       * GET /delphis/{id}.json
       * @return Delphi
       */
      $scope.getDelphi = function ( id ) {
        $delphis.getDelphi( { delphi_id:id } );
      };

      /*
       * POST /delphis
       * @param name, description, level, duration, startdate, enddate, milestone, pbstable_id, parent_id
       * @return created Delphi
       */
      $scope.newDelphi = function ( name, delphidata ) {
        $log.debug( name );

        // $delphis.save(
        $delphis.createDelphi(
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

            // refresh delphis
            $scope.delphis = $scope.refresh();
          }
        );
      };

      /*
       * PUT /delphis
       * @param Delphi Object
       * @return updated Delphi
       */
      $scope.updateDelphi = function ( delphi ) {
        $log.debug("updateDelphi", delphi);
        delphi.$updateDelphi ( function ( data ) {
          $log.debug ( data );
          // refresh delphis
            $scope.delphis = $scope.refresh();
        });
      };

      /*
       * DELETE /delphis/{id}.json
       * @param id of delphi
       */
      $scope.deleteDelphiById = function ( id ) {
        $delphis.deleteDelphi ( { delphi_id:id }, function ( data ) {
          $log.debug ( data );
          // refresh delphis
            $scope.delphis = $scope.refresh();
        });
      };

      /*
       * DELETE /delphis/{id}.json
       * @param delphi
       */
      $scope.deleteDelphi = function ( delphi ) {
        $delphis.remove ( function ( data ) {
          $log.debug ( data );
          // refresh delphis
          $scope.delphis =  $scope.refresh();
        });
      };

    });


    delphi.provider('$delphis', function () {
      var endpoint = '/delphis';

      this.setEndpoint = function ( url ) {
        endpoint = url;
      };

      this.$get = function ( $resource ) {

        return $resource (
          "/:project_id" + endpoint + "/:delphi_username" + "/:delphi_id" + ".json",
          {
            delphi_id:'@id',
            project_id:'@sub_id'
          },
          {
           'getDelphi': {method:'GET'},
           'createDelphi': {method:'POST'},
           'getDelphis': {method:'GET', isArray:true},
           'deleteDelphi': {method: 'DELETE' },
           'updateDelphi': {method: 'PUT', responseType: 'text'} //Rest delivers text not object (succes message)
          }
        );
      }
    });

    delphi.provider('deliphiEvaluation', function () {
        var endpoint = '/delphis/evaluation.json';

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

})();

"user strict";

(function () {
  var graph = angular.module('app.graph', ['templates'] );

  graph.directive('orgNodeschart', function($window, nodesGraph, $routeParams) {
    return{
      restrict: "EA",
      template: "<div id='chart_div'></div>",
      link: function(scope, elem, attrs){

        var rows;

        nodesGraph.get( $routeParams.project_id )
          .then(function (data) {
            console.log(data);
            rows = data.data;
          });

        var option = { width: 400, height: 400, title: 'Product Breakdown Structure', version: '1.1', allowHtml: true, size: 'large' }

        console.log(elem);

        google.charts.load('current', {packages:['orgchart']});
        google.charts.setOnLoadCallback(drawChart);

        // var rows = scope[attrs.chart];
        console.log("Graph directive get charData");
        // console.log(scope[attrs.chart]);

          function drawChart( ) {
            var data = new google.visualization.DataTable();
            data.addColumn('string', 'Name');
            data.addColumn('string', 'Parent');
            data.addColumn('string', 'ToolTip');

            // For each orgchart box, provide the name, manager, and tooltip to show.
            data.addRows(rows);

            // Create the chart.
            var chart = new google.visualization.OrgChart(document.getElementById('chart_div'));
            // Draw the chart, setting the allowHtml option to true for the tooltips.
            chart.draw(data, option);
          }
      }
    };
  });

    graph.directive('orgWorkschart', function($window, worksGraph, $routeParams) {
      return{
        restrict: "EA",
        template: "<div id='chart_div'></div>",
        link: function(scope, elem, attrs){

          var rows;

          worksGraph.get( $routeParams.project_id )
            .then(function (data) {
              console.log(data);
              rows = data.data;
            });

          var option = { width: 400, height: 400, title: 'Product Breakdown Structure', version: '1.1', allowHtml: true, size: 'large' }

          console.log(elem);

          google.charts.load('current', {packages:['orgchart']});
          google.charts.setOnLoadCallback(drawChart);

          // var rows = scope[attrs.chart];
          console.log("Graph directive get charData");
          // console.log(scope[attrs.chart]);

            function drawChart( ) {
              var data = new google.visualization.DataTable();
              data.addColumn('string', 'Name');
              data.addColumn('string', 'Parent');
              data.addColumn('string', 'ToolTip');

              // For each orgchart box, provide the name, manager, and tooltip to show.
              data.addRows(rows);

              // Create the chart.
              var chart = new google.visualization.OrgChart(document.getElementById('chart_div'));
              // Draw the chart, setting the allowHtml option to true for the tooltips.
              chart.draw(data, option);
            }
        }
      };
    });

    graph.directive('orgProjectschart', function($window, projectsGraph, $routeParams) {
      return{
        restrict: "EA",
        template: "<div id='chart_div'></div>",
        link: function(scope, elem, attrs){

          var rows;

          projectsGraph.get( $routeParams.project_id )
            .then(function (data) {
              console.log(data);
              rows = data.data;
            });

          var option = { width: 400, height: 400, title: 'Product Breakdown Structure', version: '1.1', allowHtml: true, size: 'large' }

          console.log(elem);

          google.charts.load('current', {packages:['orgchart']});
          google.charts.setOnLoadCallback(drawChart);

          // var rows = scope[attrs.chart];
          console.log("Graph directive get charData");
          // console.log(scope[attrs.chart]);

            function drawChart( ) {
              var data = new google.visualization.DataTable();
              data.addColumn('string', 'Name');
              data.addColumn('string', 'Parent');
              data.addColumn('string', 'ToolTip');

              // For each orgchart box, provide the name, manager, and tooltip to show.
              data.addRows(rows);

              // Create the chart.
              var chart = new google.visualization.OrgChart(document.getElementById('chart_div'));
              // Draw the chart, setting the allowHtml option to true for the tooltips.
              chart.draw(data, option);
            }
        }
      };
    });


})();

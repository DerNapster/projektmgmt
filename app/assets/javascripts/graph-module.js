"user strict";

(function () {
  var graph = angular.module('app.graph', ['templates'] );

  graph.directive('orgNodeschart', function($window, nodesGraph, $log, $routeParams) {
    return{
      restrict: "EA",
      template: "<div id='chart_div'></div>",
      link: function(scope, elem, attrs){

        nodesGraph.get( $routeParams.project_id )
          .then(function (data) {

            var rows;
            rows = data.data;

            var option = { width: 400, height: 400, title: 'Product Breakdown Structure', version: '1.1', allowHtml: true, size: 'large' }

            // google.charts.load('current', {packages:['orgchart']});
            google.charts.setOnLoadCallback(drawChart);

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
          });
      }
    };
  });

    graph.directive('orgWorkschart', function($window, worksGraph, $routeParams) {
      return{
        restrict: "EA",
        template: "<div id='chart_div'></div>",
        link: function(scope, elem, attrs){


          worksGraph.get( $routeParams.project_id )
            .then(function (data) {
              var rows;

              rows = data.data;

              var option = { width: 400, height: 400, title: 'Product Breakdown Structure', version: '1.1', allowHtml: true, size: 'large' }

              // google.charts.load('current', {packages:['orgchart']});
              google.charts.setOnLoadCallback(drawChart);

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
            });

        }
      };
    });

    graph.directive('ganttProjectschart', function($window, projectsGraph, $log, $routeParams) {
      return{
        restrict: "EA",
        template: "<div id='chart_div'></div>",
        link: function(scope, elem, attrs){

          var date;

          var rows = new Array();


          projectsGraph.get( $routeParams.project_id)
            .then(function (data) {

              var arr = data.data;

              for (i = 0; i < arr.length; i++) {

                var row = new Array();

                row.push(arr[i][0]);
                row.push(arr[i][1]);
                row.push(new Date(arr[i][2]));
                row.push(arr[i][3]);
                row.push(arr[i][4]);
                row.push(arr[i][5]);
                row.push(arr[i][6]);

                rows.push(row);
              }

              var option = { width: 400, height: 400, title: 'Product Breakdown Structure', version: '1.1', allowHtml: true, size: 'large' }

              // google.charts.load('current', {packages:['orgchart']});
              google.charts.setOnLoadCallback(drawChart);

              function drawChart( ) {
                var data = new google.visualization.DataTable();

                data.addColumn('string', 'Task ID');
                data.addColumn('string', 'Task Name');
                data.addColumn('date', 'Start Date');
                data.addColumn('date', 'End Date');
                data.addColumn('number', 'Duration');
                data.addColumn('number', 'Percent Complete');
                data.addColumn('string', 'Dependencies');
                // For each orgchart box, provide the name, manager, and tooltip to show.
                data.addRows(rows);

                // Create the chart.
                var chart = new google.visualization.Gantt(document.getElementById('chart_div'));
                // Draw the chart, setting the allowHtml option to true for the tooltips.
                chart.draw(data, option);
              }
            });


        }
      };
    });


})();

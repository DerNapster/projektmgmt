"user strict";

(function () {
  var graph = angular.module('app.graph', ['templates'] );

  /* graph.directive('graph', function () {

    return {
      restrict: 'A',
          link: function($scope, $elm, $attr) {
            var data = new google.visualization.DataTable();
            data.addColumn('string', 'Topping');
            data.addColumn('number', 'Slices');
            data.addRows([
              ['Mushrooms', 3],
              ['Onions', 1],
              ['Olives', 1],
              ['Zucchini', 1],
              ['Pepperoni', 2]
            ]);

            // For each orgchart box, provide the name, manager, and tooltip to show.
            data.addRows(rows);

            // Set chart options
          var options = {'title':'How Much Pizza I Ate Last Night',
                         'width':400,
                         'height':300};

            // Create the chart.
            var chart = new google.visualization.OPieChart($elm[0]);
            // Draw the chart, setting the allowHtml option to true for the tooltips.
            chart.draw(data, options);

      }
    }
  });*/

  graph.directive('orgCharttemp', function() {

    return {
        templateUrl: "orgchart.html",
        replace: false
    };
  });

  graph.directive('orgChart', function($window) {
    return{
      restrict: "EA",
      template: "<div id='chart_div'></div>",
      link: function(scope, elem, attrs){
        google.charts.load('current', {packages:['orgchart']});

        google.charts.setOnLoadCallback(drawChart);

        var rows = scope[attrs.chartData]

          function drawChart() {
            var data = new google.visualization.DataTable();
            data.addColumn('string', 'Name');
            data.addColumn('string', 'Parent');
            // data.addColumn('string', 'ToolTip');

            // For each orgchart box, provide the name, manager, and tooltip to show.
            data.addRows(rows);

            // Create the chart.
            var chart = new google.visualization.OrgChart(document.getElementById('chart_div'));
            // Draw the chart, setting the allowHtml option to true for the tooltips.
            chart.draw(data, {allowHtml:true});
          }
      }
    };
  });

})();
/*

  graph.directive('qnPiechart', [
      function() {
          return {
              require: '?ngModel',
              link: function(scope, element, attr, controller) {
                  var settings = {
                      is3D: true
                  };

                  var getOptions = function() {
                      return angular.extend({ }, settings, scope.$eval(attr.qnPiechart));
                  };

                  // creates instance of datatable and adds columns from settings
                  var getDataTable = function() {
                      var columns = scope.$eval(attr.qnColumns);
                      var data = new google.visualization.DataTable();
                      angular.forEach(columns, function(column) {
                          data.addColumn(column.type, column.name);
                      });
                      return data;
                  };

                  var init = function() {
                      var options = getOptions();
                      if (controller) {

                          var drawChart = function() {
                              var data = getDataTable();
                              // set model
                              data.addRows(controller.$viewValue);

                              // Instantiate and draw our chart, passing in some options.
                              var pie = new google.visualization.PieChart(element[0]);
                              pie.draw(data, options);
                          };

                          controller.$render = function() {
                              drawChart();
                          };
                      }

                      if (controller) {
                          // Force a render to override
                          controller.$render();
                      }
                  };

                  // Watch for changes to the directives options
                  scope.$watch(getOptions, init, true);
                  scope.$watch(getDataTable, init, true);
              }
          };
      }
  ]);
/*

/*


  graph.factory('graphService' function () {

    // ************** Generate the tree diagram	 *****************
    var margin = {top: 20, right: 120, bottom: 20, left: 120},
    	width = 960 - margin.right - margin.left,
    	height = 500 - margin.top - margin.bottom;

    var i = 0,
    	duration = 750,
    	root;

    var tree = d3.layout.tree()
    	.size([height, width]);

    var diagonal = d3.svg.diagonal()
    	.projection(function(d) { return [d.y, d.x]; });

    var svg = d3.select("#graph").append("svg")
    	.attr("width", width + margin.right + margin.left)
    	.attr("height", height + margin.top + margin.bottom)
      .append("g")
    	.attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    root = treeData[0];
    root.x0 = height / 2;
    root.y0 = 0;

    update(root);

    d3.select(self.frameElement).style("height", "500px");

    function update(source) {

      // Compute the new tree layout.
      var nodes = tree.nodes(root).reverse(),
    	  links = tree.links(nodes);

      // Normalize for fixed-depth.
      nodes.forEach(function(d) { d.y = d.depth * 180; });

      // Update the nodes…
      var node = svg.selectAll("g.node")
    	  .data(nodes, function(d) { return d.id || (d.id = ++i); });

      // Enter any new nodes at the parent's previous position.
      var nodeEnter = node.enter().append("g")
    	  .attr("class", "node")
    	  .attr("transform", function(d) { return "translate(" + source.y0 + "," + source.x0 + ")"; })
    	  .on("click", click);

      nodeEnter.append("circle")
    	  .attr("r", 1e-6)
    	  .style("fill", function(d) { return d._children ? "lightsteelblue" : "#fff"; });

      nodeEnter.append("text")
    	  .attr("x", function(d) { return d.children || d._children ? -13 : 13; })
    	  .attr("dy", ".35em")
    	  .attr("text-anchor", function(d) { return d.children || d._children ? "end" : "start"; })
    	  .text(function(d) { return d.name; })
    	  .style("fill-opacity", 1e-6);

      // Transition nodes to their new position.
      var nodeUpdate = node.transition()
    	  .duration(duration)
    	  .attr("transform", function(d) { return "translate(" + d.y + "," + d.x + ")"; });

      nodeUpdate.select("circle")
    	  .attr("r", 10)
    	  .style("fill", function(d) { return d._children ? "lightsteelblue" : "#fff"; });

      nodeUpdate.select("text")
    	  .style("fill-opacity", 1);

      // Transition exiting nodes to the parent's new position.
      var nodeExit = node.exit().transition()
    	  .duration(duration)
    	  .attr("transform", function(d) { return "translate(" + source.y + "," + source.x + ")"; })
    	  .remove();

      nodeExit.select("circle")
    	  .attr("r", 1e-6);

      nodeExit.select("text")
    	  .style("fill-opacity", 1e-6);

      // Update the links…
      var link = svg.selectAll("path.link")
    	  .data(links, function(d) { return d.target.id; });

      // Enter any new links at the parent's previous position.
      link.enter().insert("path", "g")
    	  .attr("class", "link")
    	  .attr("d", function(d) {
    		var o = {x: source.x0, y: source.y0};
    		return diagonal({source: o, target: o});
    	  });

      // Transition links to their new position.
      link.transition()
    	  .duration(duration)
    	  .attr("d", diagonal);

      // Transition exiting nodes to the parent's new position.
      link.exit().transition()
    	  .duration(duration)
    	  .attr("d", function(d) {
    		var o = {x: source.x, y: source.y};
    		return diagonal({source: o, target: o});
    	  })
    	  .remove();

      // Stash the old positions for transition.
      nodes.forEach(function(d) {
    	d.x0 = d.x;
    	d.y0 = d.y;
      });
    }

    // Toggle children on click.
    function click(d) {
      if (d.children) {
    	d._children = d.children;
    	d.children = null;
      } else {
    	d.children = d._children;
    	d._children = null;
      }
      update(d);
    }
  });
})();*/

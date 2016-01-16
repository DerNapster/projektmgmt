module ApplicationHelper

  def generate_organisation_graph(dataTable)
    option = { width: 400, height: 400, title: 'Product Breakdown Structure', version: '1.1', allowHtml: true, size: 'large' }
    @pbsChart = GoogleVisualr::Interactive::OrgChart.new(dataTable, option)
  end
end

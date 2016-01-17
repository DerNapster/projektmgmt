module ApplicationHelper

  def generate_organisation_graph(dataTable)
    option = { width: 400, height: 400, title: 'Product Breakdown Structure', version: '1.1', allowHtml: true, size: 'large' }
    @pbsChart = GoogleVisualr::Interactive::OrgChart.new(dataTable, option)
  end

  def sort_list_with_parent(list)
    rootElementList = list.where(parent_id: nil)
    sortedList = Array.new
    rootElement = rootElementList.first
    add_to_sorted_array sortedList, rootElement
    sortedList
  end

  def add_to_sorted_array array, element
    array << element
    if element != nil
      if element.children != nil
        element.children.each do |childElement|
          add_to_sorted_array array, childElement
        end
      end
    else
    end
  end
end

json.array!(@rams) do |ram|
  json.extract! ram, :id, :workpackage_id, :node_id, :project_id, :level, :order, :allocatable
  json.url ram_url(ram, format: :json)
end

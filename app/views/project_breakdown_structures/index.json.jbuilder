json.array!(@project_breakdown_structures) do |project_breakdown_structure|
  json.extract! project_breakdown_structure, :id, :title
  json.url project_breakdown_structure_url(project_breakdown_structure, format: :json)
end

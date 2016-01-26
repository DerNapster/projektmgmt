json.array!(@projects) do |project|
  json.extract! project, :id, :name, :description, :startdate
  json.url project_url(project, format: :json)
end

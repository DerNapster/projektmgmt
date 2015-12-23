json.array!(@components) do |component|
  json.extract! component, :id, :title, :level, :parent
  json.url component_url(component, format: :json)
end

json.array!(@rbstables) do |rbstable|
  json.extract! rbstable, :id, :name
  json.url rbstable_url(rbstable, format: :json)
end

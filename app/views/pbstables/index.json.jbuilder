json.array!(@pbstables) do |pbstable|
  json.extract! pbstable, :id, :name
  json.url pbstable_url(pbstable, format: :json)
end

json.array!(@pbs) do |pb|
  json.extract! pb, :id, :title
  json.url pb_url(pb, format: :json)
end

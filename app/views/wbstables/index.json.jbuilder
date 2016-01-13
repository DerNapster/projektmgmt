json.array!(@wbstables) do |wbstable|
  json.extract! wbstable, :id, :name, #:project_id
  json.url wbstable_url(wbstable, format: :json)
end

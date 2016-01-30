json.array!(@roles) do |role|
  json.extract! role, :id, :name, :description, :level, :qualification, :experience, :quantity, :project_id, :parent_id
  json.url role_url(role, format: :json)
end

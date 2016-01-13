json.array!(@roles) do |role|
  json.extract! role, :id, :name, :description, :qualification, :experience, :quantity, :rbstable_id, :parent_id
  json.url role_url(role, format: :json)
end

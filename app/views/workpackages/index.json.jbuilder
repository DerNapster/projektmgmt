json.array!(@workpackages) do |workpackage|
  json.extract! workpackage, :id, :name, :description, :result, :interfaces, :purchaser, :level, :duration, :startdate, :enddate, :activities, :requirements, :costs, :work, :workPerformed, :project_id, :parent_id
  json.url workpackage_url(workpackage, format: :json)
end

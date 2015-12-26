class Project < ActiveRecord::Base
  has_one :project_breakdown_structure
end

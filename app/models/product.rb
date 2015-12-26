class Product < ActiveRecord::Base
  has_many :components
  belongs_to :project_breakdown_structure
end

class Component < ActiveRecord::Base
  has_many :children, class_name: "Component", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Component"
  belongs_to :product
end

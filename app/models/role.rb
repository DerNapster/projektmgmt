class Role < ActiveRecord::Base
  belongs_to :rbstable
  belongs_to :parent, :class_name => 'Role'
  has_many :children, :class_name => 'Role', :foreign_key => 'parent_id'
  accepts_nested_attributes_for :parent
  validates :name, :rbstable, true
end

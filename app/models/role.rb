class Role < ActiveRecord::Base
  belongs_to :project
  belongs_to :parent, :class_name => 'Role'
  has_many :children, :class_name => 'Role', :foreign_key => 'parent_id'
  has_many :ram_roles
  has_many :rams, through: :ram_roles
  accepts_nested_attributes_for :parent
  validates :name, :project, presence: true
end

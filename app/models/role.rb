class Role < ActiveRecord::Base
  belongs_to :project
  belongs_to :parent, :class_name => 'Role'
  has_many :children, :class_name => 'Role', :foreign_key => 'parent_id', :dependent => :destroy
  has_many :ram_roles, :dependent => :destroy
  has_many :rams, through: :ram_roles, :dependent => :destroy
  accepts_nested_attributes_for :parent
  validates :name, :project, presence: true
end

class Project < ActiveRecord::Base
  has_many :nodes, :dependent => :destroy
  accepts_nested_attributes_for :nodes
  has_many :workpackages, :dependent => :destroy
  accepts_nested_attributes_for :workpackages
  has_many :roles, :dependent => :destroy
  accepts_nested_attributes_for :roles
  has_many :rams, :dependent => :destroy
  accepts_nested_attributes_for :rams
  validates :name, presence: true
end

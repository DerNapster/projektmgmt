class Project < ActiveRecord::Base
  has_many :nodes
  accepts_nested_attributes_for :nodes
  has_many :workpackages
  accepts_nested_attributes_for :workpackages
  has_many :roles
  accepts_nested_attributes_for :roles
  has_many :rams
  accepts_nested_attributes_for :rams
  validates :name, presence: true
end

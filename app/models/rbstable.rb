class Rbstable < ActiveRecord::Base
  belongs_to :project
  has_many :roles
  accepts_nested_attributes_for :roles
  validates :project, presence: true
end

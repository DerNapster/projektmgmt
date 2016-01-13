class Wbstable < ActiveRecord::Base
  belongs_to :project
  has_many :workpackages
  accepts_nested_attributes_for :workpackages
  validates :name, presence: true
  validates :project, presence: true
end

class Pbstable < ActiveRecord::Base
  belongs_to :project
  has_many :nodes
  accepts_nested_attributes_for :nodes
  validates :name, presence: true
  validates :project, presence: true
end

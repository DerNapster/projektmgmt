class Project < ActiveRecord::Base
  has_one :pbstable
  accepts_nested_attributes_for :pbstable
  validates :name, presence: true
end

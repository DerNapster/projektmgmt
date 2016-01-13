class Project < ActiveRecord::Base
  has_one :pbstable
  accepts_nested_attributes_for :pbstable
  has_one :wbstable
  accepts_nested_attributes_for :wbstable
  has_one :rbstable
  accepts_nested_attributes_for :rbstable
  validates :name, presence: true
end

class Project < ActiveRecord::Base
  has_one :pbstable
  accepts_nested_attributes_for :pbstable
  has_one :wbstable
  accepts_nested_attributes_for :wbstable
  validates :name, presence: true
end

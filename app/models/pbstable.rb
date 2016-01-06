class Pbstable < ActiveRecord::Base
  belongs_to :project
  has_one :node
  accepts_nested_attributes_for :node
end

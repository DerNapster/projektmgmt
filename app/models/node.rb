class Node < ActiveRecord::Base
  belongs_to :pbstable
  belongs_to :parent, :class_name => 'Node'
  has_one :children, :class_name => 'Node', :foreign_key => 'parent_id'
  accepts_nested_attributes_for :parent
end

class Node < ActiveRecord::Base
  belongs_to :pbstable, :class_name => 'Pbstable'
  belongs_to :parent, :class_name => 'Node'
  has_many :children, :class_name => 'Node', :foreign_key => 'parent_id'
  accepts_nested_attributes_for :parent
end
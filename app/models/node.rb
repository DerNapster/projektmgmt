class Node < ActiveRecord::Base
  belongs_to :pbstable
  belongs_to :parent, :class_name => 'Node'
  has_many :children, :class_name => 'Node', :foreign_key => 'parent_id'
  accepts_nested_attributes_for :parent
  validates :name, presence: true
  validates :pbstable, presence: true
  validates :startdate, presence: true
  validates :enddate, presence: true
  validates :level, presence: true
  validates :duration, presence: true
  validates :milestone, presence: true
  validate :enddate_must_be_greater_than_startdate
  validate :startdate_plus_duration_must_be_enddate


  def enddate_must_be_greater_than_startdate
    if enddate < startdate
      errors.add(:enddate, "Enddate can't be smaller than startdate")
    end
  end

  def startdate_plus_duration_must_be_enddate
    unless (startdate+duration) == enddate
      errors.add(:enddate, "Startdate plus duration must be enddate")
    end
  end
end
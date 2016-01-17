class Node < ActiveRecord::Base
  belongs_to :project
  belongs_to :parent, :class_name => 'Node'
  has_many :children, :class_name => 'Node', :foreign_key => 'parent_id'
  accepts_nested_attributes_for :parent
  validates :name, presence: true
  validates :project, presence: true
  #validates :startdate, presence: true
  #validates :enddate, presence: true
  validates :level, presence: true
  #validates :duration, presence: true
  #validate :enddate_must_be_greater_than_startdate
  #validate :startdate_plus_duration_must_be_enddate
  validate :validate_parent


  def enddate_must_be_greater_than_startdate
    if enddate < startdate
      errors.add(:enddate, "Enddate can't be smaller than startdate")
    end
  end

  def startdate_plus_duration_must_be_enddate
    unless ((enddate - startdate) == duration)
      errors.add(:enddate, "Startdate plus duration must be enddate")
    end
  end

  def validate_parent
    if parent
      #unless parent.startdate <= startdate
      #  errors.add(:parent, "Parent startdate can't be greater than child startdate")
      #end
      #unless parent.enddate >= enddate
      #  errors.add(:parent, "Parent enddate can't be smaller than child enddate")
      #end
      #unless parent.duration >= duration
      #  errors.add(:parent, "Parent duration can't be smaller than child duration")
      #end
      unless ((parent.level + 1) == level)
        errors.add(:parent, "Parent level must be one smaller than child level")
      end
      unless (parent.project.id == project.id)
        errors.add(:parent, "Parent PBSTable must be the same as child PBSTable")
      end
    end
  end
end
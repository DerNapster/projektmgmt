class Wbstable < ActiveRecord::Base
  belongs_to :project
  validates :project, presence: true
end

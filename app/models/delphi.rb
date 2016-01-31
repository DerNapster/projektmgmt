class Delphi < ActiveRecord::Base
  belongs_to :workpackage
  belongs_to :project
  accepts_nested_attributes_for :workpackage
  accepts_nested_attributes_for :project
  validates :username, presence: true
  validates :workpackagename, presence: true
  validates :workpackage, presence: true

end

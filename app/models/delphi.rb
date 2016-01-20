class Delphi < ActiveRecord::Base
  belongs_to :workpackage
  accepts_nested_attributes_for :workpackage
  validates :username, presence: true
  validates :workpackagename, presence: true
  validates :workpackage, presence: true

end

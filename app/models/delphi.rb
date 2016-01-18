class Delphi < ActiveRecord::Base
  belongs_to :workpackage
  accepts_nested_attributes_for :workpackage
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :workpackage, presence: true
  validates :value, presence: true

end

class Delphi < ActiveRecord::Base
  belongs_to :workpackage
  accepts_nested_attributes_for :workpackage
  validates :name, presence: true
  validates :workpackage, presence: true
  validates :pessimistic, presence: true
  validates :realistic, presence: true
  validates :optimistic, presence: true
  validates :round , presence: true
  validate validate_values

  def validate_values
    if optimistic > realistic
      errors.add(:optimistic, "Optimistic must be smaller than realistic")
    end
    if pessimistic < realistic
      errors.add(:optimistic, "Pessimistic must be greater than realistic")
    end
    if pessimistic < optimistic
      errors.add(:optimistic, "Pessimistic must be greater than optimistic")
    end
  end
end

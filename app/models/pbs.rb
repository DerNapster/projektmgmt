class Pbs < ActiveRecord::Base
  has_many :products
  belongs_to :project
end

class Ram < ActiveRecord::Base
  belongs_to :workpackage
  belongs_to :node
  belongs_to :project
  has_many :ram_roles, :dependent => :destroy
  has_many :roles, through: :ram_roles, :dependent => :destroy
end

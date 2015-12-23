class Product < ActiveRecord::Base
  has_many :components
end

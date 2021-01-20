class Country < ApplicationRecord
  acts_as_paranoid
  
  has_many :cities
end

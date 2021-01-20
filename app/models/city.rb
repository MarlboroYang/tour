class City < ApplicationRecord
  acts_as_paranoid
  
  belongs_to :country
  belongs_to :user
end

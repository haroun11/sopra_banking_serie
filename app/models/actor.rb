class Actor < ApplicationRecord
  
  has_many :shoot_locations
  has_many :series, through: :shoot_locations
end

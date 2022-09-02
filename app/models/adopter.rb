class Adopter < ApplicationRecord
  has_many :adopter_pets
  has_many :pets, through: :adopter_pets
end

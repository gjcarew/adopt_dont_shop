class AdopterPet < ApplicationRecord
  belongs_to :pet
  belongs_to :adopter
end

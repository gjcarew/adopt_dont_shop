class Adopter < ApplicationRecord
  has_many :adopter_pets
  has_many :pets, through: :adopter_pets
  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :description, presence: true
  validates :zip_code, presence: true, numericality: true
end

class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :adopter_pets
  has_many :adopters, through: :adopter_pets

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def application_status(adopter)
    applicant = AdopterPet.where("pet_id = ? and adopter_id = ?", self.id, adopter.id)
    applicant.first.status
  end

  def reject(adopter)
    applicant = AdopterPet.where("pet_id = ? and adopter_id = ?", self.id, adopter.id)
    applicant.first.update(status: false)
  end

  def approve(adopter)
    applicant = AdopterPet.where("pet_id = ? and adopter_id = ?", self.id, adopter.id)
    applicant.first.update(status: true)
  end
end

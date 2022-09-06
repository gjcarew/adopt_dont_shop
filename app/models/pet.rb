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

  def pet_application_status(adopter)
    applicant = AdopterPet.where("pet_id = ? and adopter_id = ?", self.id, adopter.id)
    applicant.first.status
  end

  def reject(adopter)
    applicant = AdopterPet.where("pet_id = ? and adopter_id = ?", self.id, adopter.id)
    applicant.first.update(status: false)
    adopter.update(application_status: "Rejected")
  end

  def approve(adopter)
    applicant = AdopterPet.where("pet_id = ? and adopter_id = ?", self.id, adopter.id)
    applicant.first.update(status: true)
    all_pets = AdopterPet.where("adopter_id = ?", adopter.id)
    if all_pets.all? { |pet| pet.status }
      adopter.update(application_status: "Approved")
    end
  end
end

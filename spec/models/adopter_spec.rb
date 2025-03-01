require 'rails_helper'

RSpec.describe Adopter, type: :model do
  describe 'relationships' do
    it { should have_many(:pets).through(:adopter_pets) }
    it { should have_many(:adopter_pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_numericality_of(:zip_code) }
    it { should validate_presence_of(:description) }
  end
end

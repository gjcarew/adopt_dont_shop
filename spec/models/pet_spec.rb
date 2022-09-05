require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to(:shelter) }
    it {should have_many(:adopters).through(:adopter_pets)}
    it {should have_many(:adopter_pets)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:age) }
    it { should validate_numericality_of(:age) }
  end

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        expect(Pet.search("Claw")).to eq([@pet_2])
      end
    end

    describe '#adoptable' do
      it 'returns adoptable pets' do
        expect(Pet.adoptable).to eq([@pet_1, @pet_2])
      end
    end
  end

  describe 'instance methods' do
    describe '.shelter_name' do
      it 'returns the shelter name for the given pet' do
        expect(@pet_3.shelter_name).to eq(@shelter_1.name)
      end
    end
  end

  describe 'approve and reject applications as admin' do
    before :each do
      @gavin = Adopter.create!(name: "Gavin", address: "123 turing st., Denver, CO 80302", street: '123 turing st.', city: 'Denver', state: 'CO', zip_code: '80302', description: "feed them", application_status: "Pending")
      @gavin.pets << @pet_1
    end
    it 'can check application status for a single pet' do
      expect(@pet_1.application_status(@gavin)).to be_nil
    end

    it 'can approve applications for a pet' do
      @pet_1.approve(@gavin)
      expect(@pet_1.application_status(@gavin)).to be(true)
    end

    it 'can reject applications for a pet' do
      @pet_1.reject(@gavin)
      expect(@pet_1.application_status(@gavin)).to be(false)
    end
  end
end

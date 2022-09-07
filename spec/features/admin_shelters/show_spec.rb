require 'rails_helper'

RSpec.describe 'the admin shelters show page' do
  before :each do 
    @shelter = Shelter.create(name: 'RGV animal shelter', address: 'Mock address', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @clawdia = @shelter.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pirate = @shelter.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
  end

  it "shows shelters name" do
    visit "/admin/shelters/#{@shelter.id}"
    expect(page).to have_content("RGV animal shelter")
  end

  it "shows shelters full address" do
    visit "/admin/shelters/#{@shelter.id}"
    expect(page).to have_content("Mock address")
  end

  it "shows a section for statistics" do
    visit "/admin/shelters/#{@shelter.id}"
    expect(page).to have_content("Statistics")
  end

  it "number of pets adoptable" do
    visit "/admin/shelters/#{@shelter.id}"
    expect(page).to have_content("PETS AVAILABLE: 2")
  end

  it "average age of adoptable pets" do
    visit "/admin/shelters/#{@shelter.id}"
    expect(page).to have_content("AVERAGE AGE OF ADOPTABLE PETS: 4")
  end
end

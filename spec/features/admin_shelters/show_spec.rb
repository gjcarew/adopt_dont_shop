require 'rails_helper'

RSpec.describe 'the admin shelters show page' do
  before :each do 
    @shelter = Shelter.create(name: 'RGV animal shelter', address: 'Mock address', city: 'Harlingen, TX', foster_program: false, rank: 5)
    clawdia = @shelter.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    pirate = @shelter.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    visit "/admin/shelters/#{@shelter.id}"
  end

  it "shows shelters name" do
    expect(page).to have_content("RGV animal shelter")
  end

  it "shows shelters full address" do
    expect(page).to have_content("Mock address")
  end

  it "shows a section for statistics" do
    expect(page).to have_content("Statistics")
  end

  it "number of pets adoptable" do
    expect(page).to have_content("PETS AVAILABLE: 2")
  end

end

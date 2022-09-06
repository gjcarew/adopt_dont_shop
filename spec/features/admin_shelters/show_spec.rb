require 'rails_helper'

RSpec.describe 'the admin shelters show page' do
  before :each do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @gavin = Adopter.create!(name: "Gavin", address: "123 turing st., Denver, CO 80302", street: '123 turing st.', city: 'Denver', state: 'CO', zip_code: '80302', description: "feed them", application_status: "Pending")
    @clawdia = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @gavin.pets << @clawdia
    visit "/admin/shelters/#{@shelter_1.id}"
  end

  it "shows shelters name" do
    expect(page).to have_content("RGV animal shelter")
  end

  it "shows shelters full address" do
    expect(page).to have_content("Harlingen, TX")
  end

  it "shows a section for statistics" do
    expect(page).to have_content("Statistics")
  end

  it "number of pets adoptable" do
    save_and_open_page
    expect(page).to have_content("PETS AVAILABLE")
  end
end

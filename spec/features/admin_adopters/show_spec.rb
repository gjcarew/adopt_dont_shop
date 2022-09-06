require 'rails_helper'

RSpec.describe 'Admin application show page' do
  before :each do
    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pirate = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @clawdia = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @gavin = Adopter.create!(name: "Gavin", address: "123 turing st., Denver, CO 80302", street: '123 turing st.', city: 'Denver', state: 'CO', zip_code: '80302', description: "feed them", application_status: "In Progress")
    @gavin.pets << @clawdia
    @gavin.pets << @pirate
  end

  it 'there is a button to approve every pet on the application' do
    visit "/admin/adopters/#{@gavin.id}"
    expect(page).to have_button("Approve Application for Clawdia")
    expect(page).to have_button("Approve Application for Mr. Pirate")
  end

  describe 'when I click the approve button' do
    before :each do
      visit "/admin/adopters/#{@gavin.id}"
      click_button "Approve Application for Clawdia"
    end

    it "I'm taken back to the admin application show page" do
      expect(current_path).to eq("/admin/adopters/#{@gavin.id}")
    end

    it 'There is no longer a button to approve the pet' do

      expect(page).not_to have_button("Approve Application for Clawdia")
      expect(page).to have_button("Approve Application for Mr. Pirate")
    end

    it 'There is an indicator next to the pet to show they have been approved' do
      expect(page).to have_content("Approved")
    end

  describe 'After i approve all pets' do
    xit "shows pet is no longer adoptable" do
        visit "/admin/adopters/#{@gavin.id}"
        expect(page).to have_content("Approved")
        visit "/pets/#{pet.id}"
      end
    end
  end

  it 'There is a button to reject the application for a specific pet' do
    visit "/admin/adopters/#{@gavin.id}"
    expect(page).to have_button("Reject Application for Clawdia")
    expect(page).to have_button("Reject Application for Mr. Pirate")
  end

  describe 'when I click the reject button' do
    before :each do
      visit "/admin/adopters/#{@gavin.id}"
      click_button "Reject Application for Clawdia"
    end

    it "I'm taken back to the admin application show page" do
      expect(current_path).to eq("/admin/adopters/#{@gavin.id}")
    end

    it 'There is no longer a button to approve the pet' do

      expect(page).not_to have_button("Reject Application for Clawdia")
      expect(page).to have_button("Reject Application for Mr. Pirate")
    end

    it 'There is an indicator next to the pet to show they have been rejected' do
      expect(page).to have_content("Rejected")
    end
  end
  
  it 'Approved/rejected pets on one application do not affect other applications' do
    morgan = Adopter.create!(name: "Morgan", address: "123 turing st., Denver, CO 80302", street: '123 turing st.', city: 'Denver', state: 'CO', zip_code: '80302', description: "feed them", application_status: "In Progress")
    morgan.pets << @clawdia
    morgan.pets << @pirate
    visit "/admin/adopters/#{morgan.id}"
    click_button "Approve Application for Clawdia"
    expect(page).to have_content("Approved")
    visit "/admin/adopters/#{@gavin.id}"
    expect(page).to have_button("Approve Application for Clawdia")
    expect(page).to have_button("Reject Application for Clawdia")
  end

  it 'One or more pets rejected on an application' do
    visit "/admin/adopters/#{@gavin.id}"
    click_button "Approve Application for Clawdia"
    click_button "Reject Application for Mr. Pirate"
    expect(page).to have_content("Application status: Rejected")
  end
end

require 'rails_helper'

RSpec.describe 'application show page' do
  describe 'as a visitor' do
    describe 'when i visit an application show page' do
      before :each do
        @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        @pirate = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
        @clawdia = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
        
        @gavin = @pirate.adopters.create!(name: "Gavin", address: "123 turing st., Denver, CO 80302", street: '123 turing st.', city: 'Denver', state: 'CO', zip_code: '80302', description: "feed them", application_status: "Pending")
        @gavin.pets << @clawdia
        visit "/adopters/#{@gavin.id}"
      end
      it 'see application attributes' do

        expect(page).to have_content(@gavin.name)
        expect(page).to have_content(@gavin.address)
        expect(page).to have_content(@gavin.description)
        expect(page).to have_content(@gavin.application_status)
      end

      it 'shows pets associated with application' do
        expect(page).to have_content("Clawdia")
        expect(page).to have_content("Mr. Pirate")
      end

      it "links pets to pets show page" do
        click_on("Clawdia")
        expect(current_path).to eq("/pets/#{@clawdia.id}")
      end
    end
  end
end

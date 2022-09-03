require 'rails_helper'

RSpec.describe 'application show page' do
  describe 'as a visitor' do
    describe 'when i visit an application show page' do
      before :each do
        @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
        @pirate = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
        @clawdia = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
        @lucille_bald = @shelter_2.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
        @reject = @shelter_2.pets.create(name: 'Gross Cat', breed: 'please dont let it', age: 42, adoptable: true)
        @gavin = @pirate.adopters.create!(name: "Gavin", address: "123 turing st., Denver, CO 80302", street: '123 turing st.', city: 'Denver', state: 'CO', zip_code: '80302', description: "feed them", application_status: "In Progress")
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

      it 'links pets to pets show page' do
        click_on("Clawdia")
        expect(current_path).to eq("/pets/#{@clawdia.id}")
      end

      it 'can search for pets by name' do
        expect(page).to have_content('Add a Pet to this Application')
        fill_in 'Search', with: 'Lucille Bald'
        click_on('Search')
        expect(current_path).to eq("/adopters/#{@gavin.id}")
        expect(page).to have_content(@lucille_bald.name)
        expect(page).not_to have_content(@reject.name)
      end

      it 'can search for pets with partial matching' do
        fill_in 'Search', with: 'Luc'
        click_on('Search')
        expect(current_path).to eq("/adopters/#{@gavin.id}")
        expect(page).to have_content(@lucille_bald.name)
        expect(page).not_to have_content(@reject.name)
      end

      it 'searches are case insensitive' do
        fill_in 'Search', with: 'lUc'
        click_on('Search')
        expect(current_path).to eq("/adopters/#{@gavin.id}")
        expect(page).to have_content(@lucille_bald.name)
        expect(page).not_to have_content(@reject.name)
      end

      it "has 'adopt this pet' button that links to application show page" do
        within "#adoptable-#{@lucille_bald.id}" do
          click_button('Adopt this Pet')
        end
        expect(@gavin.pets.last).to eq(@lucille_bald)
        expect(current_path).to eq("/adopters/#{@gavin.id}")
        expect(page).to have_link(@lucille_bald.name)
      end

      it "section to submit application" do

        fill_in 'Why i am a good owner', with: 'Will feed them'
        click_button("Submit application")

        expect(current_path).to eq("/adopters/#{@gavin.id}")
        expect(page).to have_content("Pending")
        expect(page).to have_content(@clawdia.name)
        expect(page).not_to have_button("Adopt this Pet")
      end
    end
  end
end

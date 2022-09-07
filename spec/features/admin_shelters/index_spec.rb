require 'rails_helper'
RSpec.describe 'the admin shelters index' do
  describe 'As an admin' do
    describe 'when I visit the admin shelter index' do
      before :each do
        @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
        @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
        @gavin = Adopter.create!(name: "Gavin", address: "123 turing st., Denver, CO 80302", street: '123 turing st.', city: 'Denver', state: 'CO', zip_code: '80302', description: "feed them", application_status: "Pending")
        @clawdia = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
        @gavin.pets << @clawdia
      end

      it 'I see all shelters in the system in reverse alphabetical order' do
        visit '/admin/shelters'
        expect(all('.shelter-name')[2].text).to eq(@shelter_1.name)
        expect(all('.shelter-name')[1].text).to eq(@shelter_3.name)
        expect(all('.shelter-name')[0].text).to eq(@shelter_2.name)
      end

      it 'I see a section for shelters with pending applications' do
        visit '/admin/shelters'
        within '#pending' do
          expect(page).to have_content(@shelter_1.name)
          expect(page).not_to have_content(@shelter_2.name)
          expect(page).not_to have_content(@shelter_3.name)
        end
      end

      it 'Pending shelters are in alphabetical order' do
        @shelter_2.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
        @shelter_3.pets.create(name: 'Gross Cat', breed: 'please dont let it', age: 42, adoptable: true)
        visit '/admin/shelters'
        expect(all('.pending-shelter')[0].text).to eq(@shelter_1.name)
        expect(all('.pending-shelter')[1].text).to eq(@shelter_3.name)
        expect(all('.pending-shelter')[2].text).to eq(@shelter_2.name)
      end
    end
  end
end

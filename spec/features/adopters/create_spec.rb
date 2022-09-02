require 'rails_helper'

RSpec.describe 'New application' do
  describe 'As a visitor' do
    describe 'when I visit the pet index page' do
      it 'I see a link to Start an Application' do
        visit '/pets'
        click_on 'Start an Application'
        expect(current_path).to eq('/adopters/new')
      end

      it 'the application has a form' do
        visit '/adopters/new'
        expect(page).to have_content('New Application for Adoption')
        expect(find('form')).to have_content('Name')
        expect(find('form')).to have_content('Street')
        expect(find('form')).to have_content('City')
        expect(find('form')).to have_content('State')
        expect(find('form')).to have_content('Zip code')
      end

      describe 'When I fill in the application' do
        it 'I see my info on the application show page' do
          visit '/adopters/new'

          fill_in 'Name', with: 'Franklin D. Roosevelt'
          fill_in 'Street', with: '1600 Pennsylvania Avenue'
          fill_in 'City', with: 'Washington'
          fill_in 'State', with: 'District of Columbia'
          fill_in 'Zip code', with: '20500'
          fill_in :description, with: 'I am the goddamn president'
          click_on 'Save'
          new_id = Adopter.last.id
          expect(current_path).to eq("/adopters/#{new_id}")
          expect(page).to have_content('Franklin D. Roosevelt')
          expect(page).to have_content('1600 Pennsylvania Avenue')
          expect(page).to have_content('Washington')
          expect(page).to have_content('District of Columbia')
          expect(page).to have_content('20500')
          expect(page).to have_content(Adopter.last.description)
          expect(page).to have_content('In Progress')
        end

        it 'If I do not fill any form fields, I get an error message' do
          visit '/adopters/new'
          click_button 'Save'
          expect(page).to have_current_path('/adopters/new')
          expect(page).to have_content("Error: Name can't be blank")
          expect(page).to have_content("City can't be blank")
          expect(page).to have_content("State can't be blank")
          expect(page).to have_content("Zip code can't be blank")
          expect(page).to have_content("Zip code is not a number")
          expect(page).to have_content("Description can't be blank")
        end
      end
    end
  end
end

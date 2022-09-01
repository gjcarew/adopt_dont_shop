require 'rails_helper'

RSpec.describe 'application show page' do
  describe 'as a visitor' do
    describe 'when i visit an application show page' do
      it 'see application attributes' do
        adopter = Adopter.create!(name: "Gavin", address: "123 turing st.", description: "feed them", application_status: "Pending")
        visit '/adopters'
        save_and_open_page
        expect(page).to have_content(adopter.name)
        expect(page).to have_content(adopter.address)
        expect(page).to have_content(adopter.description)
        expect(page).to have_content(adopter.application_status)
      end
    end
  end
end

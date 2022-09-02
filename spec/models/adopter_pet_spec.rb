require 'rails_helper'

RSpec.describe AdopterPet, type: :model do
  describe 'relationships' do
    it {should belong_to(:pet)}
    it {should belong_to(:adopter)}

  end
end

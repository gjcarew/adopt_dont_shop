require 'rails_helper'

RSpec.describe Adopter, type: :model do
  describe 'relationships' do
    it {should have_many(:pets).through(:adopter_pets)}
    it {should have_many(:adopter_pets)}
  end
end

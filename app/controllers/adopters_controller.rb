class AdoptersController < ApplicationController
  def show
    @adopter = Adopter.first
  end
end

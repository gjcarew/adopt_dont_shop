class AdoptersController < ApplicationController
  def show
    @adopter = Adopter.find(params[:id])
  end
end

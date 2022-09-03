class AdminAdoptersController < ApplicationController
  def show
    @adopter = Adopter.find(params[:id])
  end
  
  def update
    pet = Pet.find(params[:pet])
    pet.adoptable = false
    pet.save
    redirect_to "/admin/adopters/#{params[:id]}"
  end
end
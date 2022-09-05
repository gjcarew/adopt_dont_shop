class AdminAdoptersController < ApplicationController
  def show
    @adopter = Adopter.find(params[:id])
  end
  
  def update
    pet = Pet.find(params[:pet])
    adopter = Adopter.find(params[:id])
    if params[:pet_approved] == "true"
      pet.approve(adopter)
    elsif params[:pet_approved] == "false"
      pet.reject(adopter)
    end
    pet.save
    redirect_to "/admin/adopters/#{params[:id]}"
  end
end
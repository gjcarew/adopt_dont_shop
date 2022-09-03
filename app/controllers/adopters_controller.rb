class AdoptersController < ApplicationController
  def show
    @adopter = Adopter.find(params[:id])
    if params[:search].present?
      @pets = Pet.search(params[:search])
    else
      @pets = Pet.adoptable
    end
  end

  def new

  end

  def create
    adopter = Adopter.new(adopter_params)
    if adopter.save
      redirect_to "/adopters/#{adopter.id}"
    else
      redirect_to "/adopters/new"
      flash[:alert] = "Error: #{error_message(adopter.errors)}"
    end
  end

  def update
    adopter = Adopter.find(params[:applicant])
    pet = Pet.find(params[:pet])
    adopter.pets << pet
    redirect_to "/adopters/#{adopter.id}"
  end

  private

  def adopter_params
    params[:address] = params[:street] + ', ' + params[:city] + ', ' + params[:state] + params[:zip_code]
    params[:application_status] = 'In Progress'
    params.permit(:name, :address, :description, :application_status, :street, :city, :state, :zip_code)
  end

end

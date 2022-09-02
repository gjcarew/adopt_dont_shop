class AdoptersController < ApplicationController
  def show
    @adopter = Adopter.find(params[:id])
  end

  def new

  end

  def create
    adopter = Adopter.create!(adopter_params)
    redirect_to "/adopters/#{adopter.id}"
  end

  private

  def adopter_params
    params[:address] = params[:street] + ', ' + params[:city] + ', ' + params[:state] + params[:zip_code]
    params[:application_status] = 'In Progress'
    params.permit(:name, :address, :description, :application_status)
  end

end

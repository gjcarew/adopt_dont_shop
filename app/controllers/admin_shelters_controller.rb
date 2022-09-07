class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.find_by_sql("SELECT * FROM shelters ORDER BY shelters.name DESC")

  end

  def show
    @shelter = Shelter.find_by_sql(["SELECT * FROM shelters WHERE id = ?", params[:id]]).first
  end
end

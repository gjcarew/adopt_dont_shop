class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.find_by_sql("SELECT * FROM shelters ORDER BY shelters.name DESC")
  end

  def show
    @shelters = Shelter.find_by_sql("SELECT * FROM shelters ORDER BY shelters.name DESC")
  end
end

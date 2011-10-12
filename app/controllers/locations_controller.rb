class LocationsController < ApplicationController

  def new
    @location = Location.new
  end

  def create
    location = current_user.create_location!(params[:location])
    redirect_to location_url(location)
  end

  def show
    @location = Location.find(params[:id])
  end

  def schedule_pings
    head :ok
  end

end

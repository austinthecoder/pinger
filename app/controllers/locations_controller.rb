class LocationsController < ApplicationController

  respond_to :html

  expose :location

  def create
    current_user.save_location(location)
    respond_with location
  end

  def update
    location.attributes = params[:location]
    current_user.save_location(location)
    respond_with location
  end

  def destroy
    location.destroy
    respond_with location
  end

end

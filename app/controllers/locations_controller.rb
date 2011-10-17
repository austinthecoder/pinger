class LocationsController < ApplicationController

  respond_to :html

  expose :location

  expose :locations do
    Location.order { created_at.desc }.order { id.desc }
  end

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

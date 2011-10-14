class LocationsController < ApplicationController

  respond_to :html

  expose :location do
    Location.find(params[:id]) if params[:id]
  end

  def new
    @location = Location.new
  end

  def create
    respond_with current_user.create_location!(params[:location])
  end

end

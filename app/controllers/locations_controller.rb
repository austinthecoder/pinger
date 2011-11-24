class LocationsController < ApplicationController

  respond_to :html

  helper_method :location

  def create
    location.save_and_schedule_ping!
    respond_with location
  end

  def update
    location.attributes = params[:location]
    location.save_and_schedule_ping!
    respond_with location
  end

  def destroy
    location.destroy
    respond_with location
  end

##################################################

  # TODO: test
  def location
    @location ||= begin
      if params[:id]
        Location.find params[:id]
      else
        Location.new params[:location]
      end
    end
  end

end

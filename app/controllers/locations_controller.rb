class LocationsController < ApplicationController

  respond_to :html

  expose :location do
    @location || (params[:id] ? Location.find(params[:id]) : Location.new)
  end

  expose :locations do
    Location.order { created_at.desc }.order { id.desc }
  end

  def create
    respond_with current_user.create_location!(params[:location])
  rescue ActiveRecord::RecordInvalid => e
    @location = e.record
    render :new
  end

end

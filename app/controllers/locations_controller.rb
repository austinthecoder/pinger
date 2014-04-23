class LocationsController < ApplicationController
  respond_to :html

  before_filter :assign_location, :only => [:show, :edit, :update, :delete, :destroy]
  before_filter :assign_new_location, :only => [:new, :create]

  attr_reader :locations, :location, :paginated_pings

  helper_method :locations, :location, :paginated_pings

  def index
    @locations = user.paginated_locations_ordered_by_title(:page => params[:page])
  end

  def show
    @paginated_pings = @location.paginated_performed_pings(:page => params[:page])
  end

  def create
    if @location.save
      redirect_to location_url(@location)
    else
      render :new
    end
  end

  def update
    @location.attributes = params[:location]
    if @location.save
      redirect_to location_url(@location)
    else
      render :edit
    end
  end

  def destroy
    @location.destroy
    redirect_to locations_url
  end

  private

  def assign_location
    @location = user.find_location_by_param(params[:id]) or render_not_found
  end

  def assign_new_location
    @location = user.new_location params[:location]
  end
end

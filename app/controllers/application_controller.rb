class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :schedule_location_pings

  def current_user
    @current_user ||= User.new
  end

  private

  def schedule_location_pings
    Location.schedule_pings!
  end

end

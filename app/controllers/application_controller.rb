class ApplicationController < ActionController::Base

  protect_from_forgery

  expose(:current_user) { User.new }

end

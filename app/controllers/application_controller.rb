class ApplicationController < ActionController::Base
  protect_from_forgery

  def user
    User.new
  end

  def render_not_found
    respond_to do |format|
      format.html do
        render 'public/404', :status => 404, :layout => false
      end

      format.json do
        render :json => {'error' => 'Not Found'}, :status => 404
      end

      format.any do
        render :text => 'Not Found'
      end
    end
  end
end

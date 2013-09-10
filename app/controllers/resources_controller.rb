class ResourcesController < ApplicationController

  helper_method :paginated_resources

#   def create
#     if location.add
#       flash.notice = "Location was added."
#       redirect_to @location.path
#     else
#       render :new
#     end
#   end

#   def update
#     location.modify params[:location]
#     flash.notice = "Location was updated."
#     redirect_to account.locations_url
#   end

#   def destroy
#     location.destroy
#     respond_with location
#   end


#   def location
#     @location ||= if params[:id]
#       account.fetch_location params[:id]
#     else
#       account.new_location params[:location]
#     end
#   end

  def paginated_resources
    @paginated_locations ||= account.locations.order { title.asc }.page(params[:page]).per(per)
    # @paginated_resources ||= paginate account.resources
  end

#   def paginated_pings
#     @paginated_pings ||= location.ping_fetcher.performed.order { performed_at.desc }.page(params[:page]).per(30)
#   end

end

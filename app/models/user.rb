class User
  def new_location(*a)
    Location.new *a
  end

  def find_location_by_param(param)
    Location.find_by_param param
  end

  def paginated_locations_ordered_by_title(page: 1, per_page: CONFIG[:app][:locations_per_page])
    Location.order('title ASC').page(page).per(per_page)
  end

  # private

  # class LocationList
  #   def initialize(user, location_record_scope)
  #     @user = user
  #     @location_record_scope = location_record_scope
  #   end

  #   delegate :current_page, :total_pages, :limit_value, :to => :location_record_scope

  #   def each
  #     location_record_scope.each do |record|
  #       yield user.new_location(record)
  #     end
  #   end

  #   private

  #   attr_reader :user, :location_record_scope
  # end
end
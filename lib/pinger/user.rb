class User

  def create_location!(attrs = {})
    Location.create!(attrs).tap { |l| l.pings.new.schedule! }
  end

end
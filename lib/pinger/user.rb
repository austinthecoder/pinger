class User

  def save_location(location)
    location.transaction { location.schedule_ping! if location.save }
  end

end
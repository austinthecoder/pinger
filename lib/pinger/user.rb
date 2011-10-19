class User

  def save_location(location)
    location.transaction { location.schedule_ping! if location.save }
  end

  def save_email_callback(email_callback)
    email_callback.save
  end

  def save_alert(alert)
    alert.save
  end

end
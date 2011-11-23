class User

  def save_location(location)
    location.transaction { location.schedule_ping! if location.save }
  end

  def save_email_callback(email_callback)
    email_callback.save
  end

  def build_alert(params = {})
    attrs = params[:alert] || {}
    attrs[:location_id] = params[:location_id] if params[:location_id].present?
    Alert.new attrs
  end

end
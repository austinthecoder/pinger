class User

  def save_location(location)
    location.transaction { location.schedule_ping! if location.save }
  end

  def save_email_callback(email_callback)
    email_callback.save
  end

  def build_alert_from_params(params = {})
    attrs = params[:alert] || {}
    attrs[:location_id] = params[:location_id] if params[:location_id].present?
    Alert.build attrs
  end

end
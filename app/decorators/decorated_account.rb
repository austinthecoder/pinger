module DecoratedAccount

  attr_accessor :controller

  # def email_callbacks
  #   @email_callbacks ||= present fetch_email_callbacks
  # end

  # def new_email_callback(attrs = {})
  #   present account.new_email_callback(attrs)
  # end

  # def fetch_email_callback(id)
  #   present account.fetch_email_callback(id)
  # end

  # def alerts
  #   @alerts ||= present fetch_alerts
  # end

  # def new_alert(attrs = {})
  #   Alert.new.extend(DecoratedAlert).tap do |alert|
  #     alert.controller = controller
  #     alert.attributes = attrs
  #   end
  # end

  ##################################################

  def locations
    super.extend(DecoratedLocationSource).tap do |source|
      source.controller = controller
      source.account = self
    end
  end

  def new_location(attrs = {})
    locations.new attrs
  end

  def add_location(location)
    location.save_and_schedule_ping!
  end

  def fetch_location(id)
    locations.find_by_id id
  end

  def modify_location(location, attrs = {})
    location.update_attributes attrs
  end

  delegate :locations_url, :to => :controller

  ##################################################

  def email_callbacks
    super.extend(DecoratedEmailCallbackSource).tap do |source|
      source.controller = controller
      source.account = self
    end
  end

  def new_email_callback(attrs = {})
    email_callbacks.new attrs
  end

  def add_email_callback(email_callback)
    email_callback.save
  end

  def fetch_email_callback(id)
    email_callbacks.find_by_id id
  end

  def modify_email_callback(email_callback, attrs = {})
    email_callback.update_attributes attrs
  end

end
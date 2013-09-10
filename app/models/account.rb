class Account

  def schedule_pings!
    PingScheduler.perform
  end


  # def fetch_email_callbacks
  #   EmailCallback.order { label.asc }
  # end

  # def fetch_email_callback(id)
  #   EmailCallback.find_by_id(id).tap { |ec| ec.account = self }
  # end

  # def update_email_callback(email_callback)
  #   email_callback.save!
  # end

  # def new_email_callback(attrs)
  #   EmailCallback.new (attrs || {}).merge(:account => self)
  # end


  def fetch_alerts
    Alert.joins { location }.order { locations.title.asc }
  end

  def new_alert(attrs = {})
    Alert.new attrs
  end

private

  def locations
    Location.scoped
  end

  def email_callbacks
    EmailCallback.scoped
  end

end
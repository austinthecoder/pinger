module DecoratedAlert

  def location_options_for_select
    controller.locations.map { |l| [l.title, l.id] }
  end

  def email_callback_options_for_select
    controller.email_callbacks.map { |ec| [ec.label, ec.id] }
  end

  # def location
  #   present alert.location
  # end

  # def email_callback
  #   present alert.email_callback
  # end

end
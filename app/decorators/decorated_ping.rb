module DecoratedPing

  DATE_FORMAT = "%b %-d, %Y at %l:%M:%S %p %Z"

  attr_accessor :controller

  def date_performed
    performed_at.strftime DATE_FORMAT
  end

  def date_scheduled
    perform_at.strftime DATE_FORMAT
  end

end
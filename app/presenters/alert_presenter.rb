class AlertPresenter < BasePresenter

  presents :alert

  def location_options_for_select
    locations.map { |l| [l.title, l.id] }
  end

  def email_callback_options_for_select
    EmailCallback.order { label.asc }.map { |ec| [ec.label, ec.id] }
  end

end
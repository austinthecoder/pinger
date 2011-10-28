class AlertPresenter < BasePresenter

  presents :alert

  delegate :code_is_not, :times, to: :alert

  def location_options_for_select
    locations.map { |l| [l.title, l.id] }
  end

  def email_callback_options_for_select
    EmailCallback.order { label.asc }.map { |ec| [ec.label, ec.id] }
  end

  def for_url
    alert.location.try(:title)
  end

  def alert_via
    alert.email_callback.try(:label)
  end

  %w(code_is_not times).each do |name|
    define_method("#{name}_errors") { render_form_errors name }
  end

end
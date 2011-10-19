module ApplicationHelper

  def present(object, klass = nil, &block)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    if block_given?
      block.arity > 0 ? yield(presenter) : presenter.instance_eval(&block)
    end
    presenter
  end

  # TODO: test, dry up
  def locations
    @locations ||= Location.order { title.asc }
  end

  def render_main_menu
    link_args = [
      ["Add URL", new_location_path],
      ["Add email callback", new_email_callback_path]
    ]
    link_args << ["Add alert", new_alert_path] if locations.present?

    render_piped_links link_args
  end

  def render_piped_links(link_args)
    link_args.map { |a| link_to *a }.join(' | ').html_safe
  end

end

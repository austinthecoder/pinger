module ApplicationHelper

  # TODO: test
  def present(object, klass = nil, &block)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new object, self
    if block_given?
      block.arity > 0 ? yield(presenter) : presenter.instance_eval(&block)
    end
    presenter
  end

  def locations
    @locations ||= Location.order { title.asc }
  end

  def paginated_locations
    @paginated_locations ||= locations.paginate params[:page], CONFIG[:app][:locations_per_page]
  end

  def render_paginated_locations
    if paginated_locations.present?
      render 'locations/table', :locations => paginated_locations
    else
      content_tag :p, 'No URLs found.', :class => 'empty'
    end
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

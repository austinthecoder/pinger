module ApplicationHelper

  def present(object, klass = nil, &block)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    if block_given?
      block.arity > 0 ? yield(presenter) : presenter.instance_eval(&block)
    end
    presenter
  end

  def render_locations
    if locations.present?
      render 'locations/table', :locations => locations
    else
      content_tag :p, 'No URLs added.'
    end
  end

end

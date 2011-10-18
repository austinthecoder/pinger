class UserPresenter < BasePresenter

  presents :user

  def render_locations
    if locations.present?
      tpl.render 'locations/table', :locations => locations
    else
      tpl.content_tag :p, 'No URLs added.'
    end
  end

  def locations
    @locations ||= Location.order { title.asc }
  end

end
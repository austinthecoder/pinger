class UserPresenter < BasePresenter

  presents :user

  class << self
    attr_writer :locations_per_page

    def locations_per_page
      @locations_per_page ||= 30
    end
  end

  def render_locations
    if locations.present?
      tpl.render 'locations/table', :locations => locations
    else
      tpl.content_tag :p, 'No URLs have been added.', :class => 'empty'
    end
  end

  def locations
    @locations ||= tpl.locations.page(tpl.params[:page]).per(self.class.locations_per_page)
  end

end
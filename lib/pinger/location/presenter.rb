class Location
  class Presenter < Poser::Presenter

    presents :location

    delegate :id, to: :location

    def next_ping
      now = Time.now
      if location.next_ping_date && location.next_ping_date > now
        distance_of_time_in_words now, location.next_ping_date
      else
        'just a moment'
      end
    end

    def title
      @title ||= TitleAttribute.new(self)
    end

    def http_method
      @http_method ||= HttpMethodAttribute.new(self)
    end

    def seconds
      @seconds ||= SecondsAttribute.new(self)
    end

    def url
      @url ||= UrlAttribute.new(self)
    end

    def pings
      @ping ||= location.pings.performed.order { performed_at.desc }
    end

    def paginated_pings
      @paginated_pings ||= pings.paginate params[:page], CONFIG[:app][:pings_per_page]
    end

    def render_pings
      if paginated_pings.present?
        render 'pings/table', pings: paginated_pings
      else
        content_tag :p, 'No pings yet.', class: 'empty'
      end
    end

    [nil, :edit, :delete].each do |name|
      define_method (name ? "#{name}_path" : 'path') do
        send (name ? "#{name}_location_path" : 'location_path'), location
      end
    end

    # TODO: test
    attr_accessor :form_builder

    # TODO: test
    def form
      form_for location do |f|
        self.form_builder = f
        yield
        self.form_builder = nil
      end
    end

  end
end

require 'location/presenter/http_method_attribute'
require 'location/presenter/seconds_attribute'
require 'location/presenter/title_attribute'
require 'location/presenter/url_attribute'
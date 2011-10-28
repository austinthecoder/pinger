class LocationPresenter
  class Form < FormPresenter

    field :title
    field :url
    field :http_method
    field :seconds

    # TODO: test
    delegate :location, to: :location_presenter

    # TODO: test
    def button
      button_tag (location.new_record? ? 'Add' : 'Save') + ' URL'
    end

  private

    alias_method :location_presenter, :object_presenter

  end
end
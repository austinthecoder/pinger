class LocationPresenter
  class Attribute

    def initialize(location_presenter)
      @location_presenter = location_presenter
    end

    attr_reader :location_presenter

    delegate :form_builder, :location, :render, to: :location_presenter

    delegate :text_field, :select, :to => :form_builder

  end
end
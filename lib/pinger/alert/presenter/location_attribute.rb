require 'alert/presenter/attribute'

class Alert
  class Presenter
    class LocationAttribute < Attribute

      delegate :location_options_for_select, to: :presenter

      def label
        form_builder.label :location_id, 'For'
      end

      def field
        select :location_id, location_options_for_select
      end

      def errors
      end

      def to_s
        alert.location.try(:title).to_s
      end

    end
  end
end
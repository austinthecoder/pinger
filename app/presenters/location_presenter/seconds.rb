class LocationPresenter
  class Seconds < Attribute

    def label
      form_builder.label :seconds
    end

    def field
      text_field :seconds, max_length: 255, size: 20
    end

    def errors
      errors = location.errors[:seconds]
      if errors.present?
        render 'shared/form_errors', errors: errors.map(&:capitalize)
      end
    end

    def to_s
      location.seconds
    end

  end
end
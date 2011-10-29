require 'location_presenter/attribute'

class LocationPresenter
  class Title < LocationPresenter::Attribute

    def label
      form_builder.label :title
    end

    def field
      text_field :title, max_length: 255, size: 50
    end

    def errors
      errors = location.errors[:title]
      if errors.present?
        render 'shared/form_errors', errors: errors.map(&:capitalize)
      end
    end

    def to_s
      location.title
    end

  end
end
class LocationPresenter
  class Url < Attribute

    def label
      form_builder.label :url, 'URL'
    end

    def field
      text_field :url, max_length: 255, size: 80
    end

    def errors
      errors = location.errors[:url]
      if errors.present?
        render 'shared/form_errors', errors: errors.map(&:capitalize)
      end
    end

    def to_s
      location.url
    end

  end
end
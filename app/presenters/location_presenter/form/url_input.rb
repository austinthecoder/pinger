class LocationPresenter
  class Form
    # TODO: test
    class UrlInput < FormPresenter::Input

      def label
        form_presenter.label :url, 'URL'
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

    end
  end
end
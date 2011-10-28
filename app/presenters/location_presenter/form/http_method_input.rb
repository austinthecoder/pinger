class LocationPresenter
  class Form
    # TODO: test
    class HttpMethodInput < FormPresenter::Input

      def label
        form_presenter.label :http_method, 'HTTP method'
      end

      def field
        # TODO: refactor out http method options into method
        select :http_method, Location::HTTP_METHODS.map(&:upcase)
      end

      def errors
        errors = location.errors[:http_method]
        if errors.present?
          render 'shared/form_errors', :errors => errors.map(&:capitalize)
        end
      end

    end
  end
end
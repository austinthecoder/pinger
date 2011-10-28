class LocationPresenter
  class Form
    # TODO: test
    class SecondsInput < FormPresenter::Input

      def label
        form_presenter.label :seconds
      end

      def field
        text_field :seconds, :max_length => 255, :size => 20
      end

      def errors
        errors = location.errors[:seconds]
        if errors.present?
          render 'shared/form_errors', :errors => errors.map(&:capitalize)
        end
      end

    end
  end
end
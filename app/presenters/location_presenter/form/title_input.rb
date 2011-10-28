class LocationPresenter
  class Form
    # TODO: test
    class TitleInput < FormPresenter::Input

      def label
        form_presenter.label :title
      end

      def field
        text_field :title, :max_length => 255, :size => 50
      end

      def errors
        errors = location.errors[:title]
        if errors.present?
          render 'shared/form_errors', :errors => errors.map(&:capitalize)
        end
      end

    end
  end
end
require 'email_callback/presenter/attribute'

class EmailCallback
  class Presenter
    class LabelAttribute < Attribute

      def label
        form_builder.label :label
      end

      def field
        text_field :label, max_length: 255, size: 50
      end

      def errors
        errors = email_callback.errors[:label]
        if errors.present?
          render 'shared/form_errors', errors: errors.map(&:capitalize)
        end
      end

      def to_s
        email_callback.label
      end

    end
  end
end
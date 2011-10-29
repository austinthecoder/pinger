require 'alert_presenter/attribute'

class AlertPresenter
  class CodeIsNot < AlertPresenter::Attribute

    def label
      form_builder.label :code_is_not, 'Response status code is not'
    end

    def field
      text_field :code_is_not, max_length: 255, size: 20
    end

    def errors
      errors = alert.errors[:code_is_not]
      if errors.present?
        render 'shared/form_errors', errors: errors.map(&:capitalize)
      end
    end

    # TODO: test
    def to_s
      alert.code_is_not.to_s
    end

  end
end
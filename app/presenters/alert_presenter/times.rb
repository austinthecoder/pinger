require 'alert_presenter/attribute'

class AlertPresenter
  class Times < AlertPresenter::Attribute

    def label
      form_builder.label :times, 'Times in a row'
    end

    def field
      text_field :times, max_length: 255, size: 20
    end

    def errors
      errors = alert.errors[:times]
      if errors.present?
        render 'shared/form_errors', errors: errors.map(&:capitalize)
      end
    end

    # TODO: test
    def to_s
      alert.times.to_s
    end

  end
end
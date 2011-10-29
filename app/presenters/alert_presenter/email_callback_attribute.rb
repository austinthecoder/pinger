require 'alert_presenter/attribute'

class AlertPresenter
  class EmailCallbackAttribute < AlertPresenter::Attribute

    delegate :email_callback_options_for_select, to: :presenter

    def label
      form_builder.label :email_callback_id, 'Alert via'
    end

    def field
      select :email_callback_id, email_callback_options_for_select
    end

    def errors
      errors = alert.errors[:times]
      if errors.present?
        render 'shared/form_errors', errors: errors.map(&:capitalize)
      end
    end

    # TODO: test
    def to_s
      alert.email_callback.try(:label).to_s
    end

  end
end
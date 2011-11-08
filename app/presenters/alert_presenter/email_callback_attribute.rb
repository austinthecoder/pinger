require 'alert_presenter/attribute'

class AlertPresenter
  class EmailCallbackAttribute < AlertPresenter::Attribute

    # TODO: test
    delegate :link_to, :new_email_callback_path, :email_callback_options_for_select, to: :presenter

    def label
      form_builder.label :email_callback_id, 'Alert via'
    end

    # TODO: test
    def field
      if email_callback_options_for_select.empty?
        "There are no email callbacks. #{link_to "Add one", new_email_callback_path}".html_safe
      else
        select :email_callback_id, email_callback_options_for_select
      end
    end

    def errors
      errors = alert.errors[:email_callback_id]
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
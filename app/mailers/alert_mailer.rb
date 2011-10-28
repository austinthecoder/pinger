class AlertMailer < ActionMailer::Base

  default from: "mailer@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.email_callback_mailer.notification.subject
  #
  def notification(alert)
    @location_title = alert.location.title
    @correct_status_code = alert.code_is_not

    mail(
      to: alert.email_callback.to,
      subject: t('email_callback_mailer.notification.subject', location_title: @location_title)
    )
  end

end

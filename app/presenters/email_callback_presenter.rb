class EmailCallbackPresenter < BasePresenter

  presents :email_callback

  delegate :label, :to => :email_callback

  def email
    email_callback.to
  end

  [['email', 'to'], ['label', 'label']].each do |prefix, attr_name|
    define_method("#{prefix}_errors") { render_form_errors attr_name }
  end

end
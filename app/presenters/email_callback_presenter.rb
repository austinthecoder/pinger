class EmailCallbackPresenter < BasePresenter

  presents :email_callback

  delegate :id, :label, to: :email_callback

  def email
    email_callback.to
  end

  [['email', 'to'], ['label', 'label']].each do |prefix, attr_name|
    define_method("#{prefix}_errors") { render_form_errors attr_name }
  end

  def edit_path
    edit_email_callback_path(email_callback)
  end

  def delete_path
    delete_email_callback_path(email_callback)
  end

  def form_button_text
    (email_callback.new_record? ? 'Add' : 'Save') + ' email callback'
  end

end
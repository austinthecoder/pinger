class EmailCallbackPresenter < Poser::Presenter

  presents :email_callback

  delegate :id, to: :email_callback

  def email
    @email ||= EmailAttribute.new(self)
  end

  def label
    @label ||= LabelAttribute.new(self)
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

  # TODO: test
  attr_accessor :form_builder

  # TODO: test
  def form
    form_for email_callback do |f|
      self.form_builder = f
      yield
      self.form_builder = nil
    end
  end

end

require 'email_callback_presenter/email_attribute'
require 'email_callback_presenter/label_attribute'
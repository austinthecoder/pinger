class EmailCallbackPresenter < BasePresenter

  presents :email_callback

  [['email', 'to'], ['label', 'label']].each do |prefix, attr_name|
    define_method "#{prefix}_errors" do
      render_form_errors attr_name
    end
  end

end
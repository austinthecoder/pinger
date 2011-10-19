class EmailCallbackPresenter < BasePresenter

  presents :email_callback

  [['email', 'to'], ['label', 'label']].each do |prefix, attr_name|
    define_method "#{prefix}_errors" do
      if (errors = email_callback.errors[attr_name].map(&:capitalize)).present?
        tpl.render 'shared/form_errors', :errors => errors
      end
    end
  end

end
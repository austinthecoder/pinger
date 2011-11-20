require 'spec_helper'

describe EmailCallbackPresenter do

  let :email_callback do
    build :email_callback, id: 349578, label: 'abc', to: 'x@y.com'
  end

  subject { described_class.new email_callback, view }

  [['email', 'to'], ['label', 'label']].each do |prefix, attr_name|
    describe "#{prefix}_errors" do
      it "renders form errors for the email callback's #{attr_name}" do
        form_errors = mock(Object)
        subject.stub(:render_form_errors) { |a| form_errors if a == attr_name }

        subject.send("#{prefix}_errors").should == form_errors
      end
    end
  end

  it { subject.label.should == EmailCallbackPresenter::LabelAttribute.new(subject) }

  it { subject.email.should == EmailCallbackPresenter::EmailAttribute.new(subject) }

  describe "id" do
    it "returns the email callback's id" do
      subject.id.should == 349578
    end
  end

  describe "edit_path" do
    context "when the email callback is an existing record" do
      before { email_callback.save! }
      its(:edit_path) { should == view.edit_email_callback_path(email_callback) }
    end
  end

  describe "delete_path" do
    context "when the email callback is an existing record" do
      before { email_callback.save! }
      its(:delete_path) { should == view.delete_email_callback_path(email_callback) }
    end
  end

  describe "form_button_text" do
    context "when the email callback is a new record" do
      its(:form_button_text) { should == 'Add email callback' }
    end

    context "when the email callback is persisted" do
      before { email_callback.save! }
      its(:form_button_text) { should == 'Save email callback' }
    end
  end
end
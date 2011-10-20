require 'spec_helper'

describe EmailCallbackPresenter do
  subject { described_class.new email_callback, view }

  let(:email_callback) { Factory.build :email_callback }

  [['email', 'to'], ['label', 'label']].each do |prefix, attr_name|
    describe "#{prefix}_errors" do
      it "renders form errors for the email callback's #{attr_name}" do
        form_errors = mock(Object)
        subject.stub(:render_form_errors) { |a| form_errors if a == attr_name }

        subject.send("#{prefix}_errors").should == form_errors
      end
    end
  end
end
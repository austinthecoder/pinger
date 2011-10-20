require 'spec_helper'

describe EmailCallbackPresenter do
  subject { described_class.new email_callback, view }

  let(:email_callback) { Factory.build :email_callback }

  [['email', 'to'], ['label', 'label']].each do |prefix, attr_name|
    describe "#{prefix}_errors" do
      context "when the email callback's #{attr_name} has errors" do
        before do
          email_callback.errors.add attr_name, 'is invalid'
          email_callback.errors.add attr_name, "can't be blank"
        end
        it "renders the form errors" do
          view.should_receive(:render).with 'shared/form_errors',
            :errors => ["Is invalid", "Can't be blank"]
          subject.send "#{prefix}_errors"
        end
      end

      context "when the email callback's #{attr_name} doesn't have errors" do
        its("#{prefix}_errors") { should be_blank }
      end
    end
  end

end
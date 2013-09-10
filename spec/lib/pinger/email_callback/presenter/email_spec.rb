require 'spec_helper'

describe EmailCallback::Presenter::EmailAttribute do

  let :email_callback_presenter do
    double 'EmailCallback::Presenter', email_callback: double('EmailCallback', to: 'x@y.com')
  end

  subject { described_class.new email_callback_presenter }

  it { should be_a(EmailCallback::Presenter::Attribute) }

  its(:to_s) { should == "x@y.com" }

end
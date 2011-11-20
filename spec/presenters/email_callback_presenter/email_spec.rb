require 'spec_helper'

describe EmailCallbackPresenter::EmailAttribute do

  let :email_callback_presenter do
    mock EmailCallbackPresenter, email_callback: mock(EmailCallback, to: 'x@y.com')
  end

  subject { described_class.new email_callback_presenter }

  it { should be_a(EmailCallbackPresenter::Attribute) }

  its(:to_s) { should == "x@y.com" }

end
require 'spec_helper'

describe EmailCallback::Presenter::LabelAttribute do

  let :email_callback_presenter do
    double 'EmailCallback::Presenter', email_callback: double('EmailCallback', label: 'label')
  end

  subject { described_class.new email_callback_presenter }

  it { should be_a(EmailCallback::Presenter::Attribute) }

  its(:to_s) { should == "label" }

end
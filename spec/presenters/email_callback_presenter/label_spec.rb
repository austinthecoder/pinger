require 'spec_helper'

describe EmailCallbackPresenter::LabelAttribute do

  let :email_callback_presenter do
    mock EmailCallbackPresenter, email_callback: mock(EmailCallback, label: 'label')
  end

  subject { described_class.new email_callback_presenter }

  it { should be_a(EmailCallbackPresenter::Attribute) }

  its(:to_s) { should == "label" }

end
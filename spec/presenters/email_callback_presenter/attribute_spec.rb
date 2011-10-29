require 'spec_helper'

describe EmailCallbackPresenter::Attribute do

  let :email_callback_presenter do
    mock EmailCallbackPresenter, email_callback: mock(EmailCallback)
  end

  subject { described_class.new email_callback_presenter }

  it { should be_a(Poser::Presenter::Attribute) }

  [:email_callback].each do |method|
    it "delegates #{method} to the email callback presenter" do
      result = mock Object
      args = [mock(Object), mock(Object)]
      email_callback_presenter.should_receive(method).with(*args).and_return(result)
      subject.send(method, *args).should == result
    end
  end

end
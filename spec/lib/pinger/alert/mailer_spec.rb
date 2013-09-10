require "spec_helper"

describe Alert::Mailer do

  describe "notification" do
    subject { described_class.notification(alert) }

    let :alert do
      double 'alert',
        location: double('location', title: 'Google Homepage'),
        email_callback: double('email_callback', to: 'me@example.com'),
        code_is_not: '201'
    end

    its(:subject) { should == '"Google Homepage" alert' }
    its(:to) { should == ['me@example.com'] }
    its(:from) { should == ['mailer@example.com'] }

    it "renders the body" do
      subject.body.encoded.should == '"Google Homepage" is not returning status codes of "201".'
    end
  end

end

require "spec_helper"

describe AlertMailer do

  describe "notification" do
    subject { described_class.notification(alert) }

    let :alert do
      mock Alert,
        location: mock(Location, title: 'Google Homepage'),
        email_callback: mock(EmailCallback, to: 'me@example.com'),
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

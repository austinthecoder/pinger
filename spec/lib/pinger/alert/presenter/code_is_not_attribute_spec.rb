require 'spec_helper'

describe Alert::Presenter::CodeIsNotAttribute do

  let :alert_presenter do
    mock Alert::Presenter, alert: mock(Alert)
  end

  subject { described_class.new alert_presenter }

  it { should be_a(Alert::Presenter::Attribute) }

end
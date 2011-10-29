require 'spec_helper'

describe AlertPresenter::Times do

  let :alert_presenter do
    mock AlertPresenter, alert: mock(Alert)
  end

  subject { described_class.new alert_presenter }

  it { should be_a(AlertPresenter::Attribute) }

end
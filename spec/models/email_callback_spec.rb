require 'spec_helper'

describe EmailCallback do

  subject { build :email_callback }

  it { should be_valid }

  it { should_not accept_values_for(:to, nil, '') }

  it { should_not accept_values_for(:label, nil, '') }

  it "requires unique label" do
    ec = create :email_callback
    should_not accept_values_for(:label, ec.label)
  end

end

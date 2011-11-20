require 'spec_helper'

describe EmailCallback do

  subject { build :email_callback }

  it { should be_valid }

  it { should accept_values_for(:to, ('a' * 255)) }
  it { should_not accept_values_for(:to, nil, '', ('a' * 256)) }

  it { should accept_values_for(:label, ('a' * 255)) }
  it { should_not accept_values_for(:label, nil, '', ('a' * 256)) }

  it "requires unique label" do
    ec = create :email_callback
    should_not accept_values_for(:label, ec.label)
  end

end

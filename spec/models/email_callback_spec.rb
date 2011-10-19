require 'spec_helper'

describe EmailCallback do

  subject { Factory.build(:email_callback) }

  it { should be_valid }

end

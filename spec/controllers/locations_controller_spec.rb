require 'spec_helper'

describe LocationsController do

  subject { controller }

  describe "locations" do
    it "returns the locations, newest first" do
      Timecop.freeze(Time.now) do
        locations = [
          Factory(:location, :id => 3000, :created_at => 2.minutes.ago),
          Factory(:location, :id => 2000, :created_at => 2.minutes.ago),
          Factory(:location, :created_at => 3.minutes.ago)
        ]
        subject.locations.should == locations
      end
    end
  end

end

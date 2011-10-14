require 'spec_helper'

describe ApplicationHelper do

  subject { helper }

  describe "render_locations" do
    context "when there are locations" do
      before do
        @locations = [mock(Location)]
        subject.stub(:locations) { @locations }
      end
      it "tells itself to render the locations table" do
        subject.should_receive(:render).with('locations/table', :locations => @locations)
        subject.render_locations
      end
    end

    context "when there are no locations" do
      before { subject.stub(:locations) }
      it { subject.render_locations.should == "<p>No URLs added.</p>" }
    end
  end

end

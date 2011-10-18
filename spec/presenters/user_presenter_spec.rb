require 'spec_helper'

describe UserPresenter do
  subject { described_class.new(user, view) }

  let(:user) { User.new }

  describe "render_locations" do
    context "when there are locations" do
      before do
        @locations = [mock(Location)]
        subject.stub(:locations) { @locations }
      end

      it "tells the template to render the locations table" do
        view.should_receive(:render).with('locations/table', :locations => @locations)
        subject.render_locations
      end
    end

    context "when there are no locations" do
      before { subject.stub(:locations) }
      it { subject.render_locations.should =~ /No URLs have been added/ }
    end
  end

  describe "locations" do
    context "when there are locations" do
      before do
        @c = Factory(:location, :title => 'c')
        @b = Factory(:location, :title => 'b')
        @a = Factory(:location, :title => 'a')
      end

      its(:locations) { should == [@a, @b, @c] }

      context "when showing 3 locations per page" do
        before do
          UserPresenter.locations_per_page = 3
          2.times { Factory(:location) }
        end
        [[1, 3], [2, 2]].each do |page, num_locations|
          context "when the page is #{page}" do
            before { view.params[:page] = page.to_s }
            it { subject.locations.size.should == num_locations }
          end
        end
      end
    end

    context "when there are no locations" do
      its(:locations) { should be_empty }
    end
  end

end
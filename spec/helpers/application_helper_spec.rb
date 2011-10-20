require 'spec_helper'

describe ApplicationHelper do

  subject { helper }

  describe "locations" do
    context "when there are locations" do
      before do
        @c = Factory :location, :title => 'c'
        @b = Factory :location, :title => 'b'
        @a = Factory :location, :title => 'a'
      end
      it "returns them, ordered by title" do
        subject.locations.should == [@a, @b, @c]
      end
    end

    context "when there are no locations" do
      its(:locations) { should be_empty }
    end
  end

  describe "paginated_locations" do
    it "returns the locations, paginated" do
      paginated_locations = mock Object
      subject.locations.stub(:paginate) do |page, per_page|
        paginated_locations if page == 7 && per_page == 3
      end
      subject.params[:page] = 7

      subject.paginated_locations.should == paginated_locations
    end
  end

  describe "render_paginated_locations" do
    context "when there are paginated locations" do
      before do
        @locs = [mock(Location)]
        subject.stub(:paginated_locations) { @locs }
      end
      it "renders the locations table" do
        subject.should_receive(:render).with 'locations/table', :locations => @locs
        subject.render_paginated_locations
      end
    end

    context "when there are no paginated locations" do
      before { subject.stub :paginated_locations }
      it { subject.render_paginated_locations.should =~ /No URLs found/ }
    end
  end

  describe "render_main_menu" do
    context "when there are locations" do
      before { subject.stub(:locations) { [mock(Location)] } }
      it "should render the main menu as piped links" do
        subject.should_receive(:render_piped_links).with [
          ["Add URL", new_location_path],
          ["Add email callback", new_email_callback_path],
          ["Add alert", new_alert_path]
        ]
        subject.render_main_menu
      end
    end

    context "when there are no locations" do
      before { subject.stub :locations }
      it "should render the main menu, without the 'Add alert' item, as piped links" do
        subject.should_receive(:render_piped_links).with [
          ["Add URL", new_location_path],
          ["Add email callback", new_email_callback_path]
        ]
        subject.render_main_menu
      end
    end
  end

  describe "render_piped_links" do
    context "with link args" do
      before { @link_args = [['a', '/'], ['b', '/foo']] }

      it "returns links delimited by pipes" do
        subject.render_piped_links(@link_args).should == "#{subject.link_to 'a', '/'} | #{subject.link_to 'b', '/foo'}"
      end

      it("is html safe") { subject.render_piped_links(@link_args).should be_html_safe }
    end
  end

end

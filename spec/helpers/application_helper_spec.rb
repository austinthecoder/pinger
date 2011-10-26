require 'spec_helper'

describe ApplicationHelper do

  subject { helper }

  describe "locations" do
    context "when there are locations" do
      before do
        @c = create :location, :title => 'c'
        @b = create :location, :title => 'b'
        @a = create :location, :title => 'a'
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

  describe "main_menu" do
    its :main_menu do
      should == [
        ["Add URL", new_location_path],
        ["Email callbacks", email_callbacks_path],
        ["Alerts", alerts_path]
      ]
    end
  end

  describe "alerts" do
    context "when there are alerts" do
      before do
        @c = create :alert, :location => create(:location, :title => 'c')
        @b = create :alert, :location => create(:location, :title => 'b')
        @a = create :alert, :location => create(:location, :title => 'a')
      end
      it "returns them, ordered by location's title" do
        subject.alerts.should == [@a, @b, @c]
      end
    end

    context "when there are no alerts" do
      its(:alerts) { should be_empty }
    end
  end

  describe "alerts_menu" do
    before do
      subject.stub(:locations) { [mock(Location)] }
      subject.stub(:email_callbacks) { [mock(EmailCallback)] }
    end

    context "when there are locations and email callbacks" do
      its(:alerts_menu) { should == [["Add alert", new_alert_path]] }
    end

    context "when there are locations but no email callbacks" do
      before { subject.stub :email_callbacks }
      its(:alerts_menu) { should be_empty }
    end

    context "when there are email callbacks but no locations" do
      before { subject.stub :locations }
      its(:alerts_menu) { should be_empty }
    end
  end

  describe "email_callbacks_menu" do
    its :email_callbacks_menu do
      should == [["Add email callback", new_email_callback_path]]
    end
  end

  describe "email_callbacks" do
    context "when there are email callbacks" do
      before do
        @c = create :email_callback, :label => 'c'
        @b = create :email_callback, :label => 'b'
        @a = create :email_callback, :label => 'a'
      end
      it "returns them, ordered by label" do
        subject.email_callbacks.should == [@a, @b, @c]
      end
    end

    context "when there are no email callbacks" do
      its(:email_callbacks) { should be_empty }
    end
  end

end

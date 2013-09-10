require 'spec_helper'

describe ApplicationHelper do

  subject { helper }

  describe "locations" do
    context "when there are locations" do
      before do
        @c = create :location, title: 'c'
        @b = create :location, title: 'b'
        @a = create :location, title: 'a'
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
      paginated_locations = double 'object'
      subject.locations.stub(:paginate) do |page, per_page|
        paginated_locations if page == 7 && per_page == 3
      end
      subject.params[:page] = 7

      subject.paginated_locations.should == paginated_locations
    end
  end

  describe "alerts" do
    context "when there are alerts" do
      before do
        @c = create :alert, location: create(:location, title: 'c')
        @b = create :alert, location: create(:location, title: 'b')
        @a = create :alert, location: create(:location, title: 'a')
      end
      it "returns them, ordered by location's title" do
        subject.alerts.should == [@a, @b, @c]
      end
    end

    context "when there are no alerts" do
      its(:alerts) { should be_empty }
    end
  end

  describe "email_callbacks" do
    context "when there are email callbacks" do
      before do
        @c = create :email_callback, label: 'c'
        @b = create :email_callback, label: 'b'
        @a = create :email_callback, label: 'a'
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

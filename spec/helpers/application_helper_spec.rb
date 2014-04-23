require 'spec_helper'

describe ApplicationHelper do
  subject { helper }

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

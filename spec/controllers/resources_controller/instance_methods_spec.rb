require 'spec_helper'

describe ResourcesController, "instance methods" do
  subject { controller }

  describe "paginated_resources" do
    before do
      @account = subject.account
    end

    it "returns the account's resources, paginated" do
      resources = Object.new
      @account.stub(:resources) { resources }

      paginated_resources = Object.new
      subject.stub :paginate do |object|
        paginated_resources if object == resources
      end

      subject.paginated_resources.should == paginated_resources
    end
  end
end
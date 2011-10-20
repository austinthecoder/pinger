require 'spec_helper'

describe LocationPresenter do
  subject { described_class.new location, view }

  let :location do
    Factory :location,
      :id => 346785,
      :title => 'Google',
      :seconds => 10,
      :url => 'http://x.com',
      :http_method => 'get'
  end

  %w(id seconds url title).each do |method|
    describe "#{method}" do
      it "delegates to the location" do
        subject.send(method).should === location.send(method)
      end
    end
  end

  describe "next_ping" do
    before { Timecop.freeze Time.now }
    after { Timecop.return }

    context "when the location's next ping date is in the future" do
      before { location.stub(:next_ping_date) { 3.minutes.from_now } }
      it "returns the distance of time, in words, until then" do
        subject.next_ping.should == '3 minutes'
      end
    end

    [
      ['now', lambda { Time.now }],
      ["in the past", lambda { 2.minutes.ago }],
      ["nil", lambda { nil }]
    ].each do |text, method_block|
      context "when the location's next ping date is #{text}" do
        before { location.stub :next_ping_date, method_block }
        it { subject.next_ping.should == 'just a moment' }
      end
    end
  end

  describe "http_method" do
    it "returns the location's http method upcased" do
      subject.http_method.should == 'GET'
    end
  end

  describe "pings" do
    before do
      Factory :ping, :performed_at => 1.minute.ago # performed, not for location
      Factory :ping, :location => location, :performed_at => nil # not performed, for location
    end

    context "when the location has performed pings" do
      before do
        @pings = [3, 4, 2, 5, 1].map do |i|
          Factory :ping, :location => location, :performed_at => i.minutes.ago
        end
      end
      it "returns those pings, ordered by date performed" do
        subject.pings.should == [@pings[4], @pings[2], @pings[0], @pings[1], @pings[3]]
      end
    end

    context "when the location doesn't have performed pings" do
      its(:pings) { should be_empty }
    end
  end

  describe "paginated_pings" do
    it "returns the pings, paginated" do
      paginated_pings = mock Object
      subject.pings.stub(:paginate) do |page, per_page|
        paginated_pings if page == 7 && per_page == 3
      end
      subject.params[:page] = 7

      subject.paginated_pings.should == paginated_pings
    end
  end

  describe "render_pings" do
    context "when there are paginated pings" do
      before do
        @paginated_pings = [mock(Ping)]
        subject.stub(:paginated_pings) { @paginated_pings }
      end
      it "tells the view to render the pings table" do
        view.should_receive(:render).with 'pings/table', :pings => @paginated_pings
        subject.render_pings
      end
    end

    context "when there are no paginated pings" do
      before { subject.stub :paginated_pings }
      it "returns a no-pings msg" do
        subject.render_pings.should =~ /No pings yet/
      end
    end
  end

  %w(title url http_method seconds).each do |name|
    describe "#{name}_errors" do
      it "renders form errors for the location's #{name}" do
        form_errors = mock(Object)
        subject.stub(:render_form_errors) { |a| form_errors if a == name }

        subject.send("#{name}_errors").should == form_errors
      end
    end
  end

  its(:path) { should == view.location_path(location) }
  its(:edit_path) { should == view.edit_location_path(location) }
  its(:delete_path) { should == view.delete_location_path(location) }
end
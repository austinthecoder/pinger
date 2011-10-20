require 'spec_helper'

shared_examples "a paginator" do
  describe "class methods" do
    subject { described_class }

    describe "paginate" do
      context "when there are 10 #{subject.to_s.downcase} and 3 per page" do
        before do
          @items = 10.times.map { Factory(subject.to_s.downcase.to_sym) }
          @per_page = 3
        end

        [
          [1, 1, 3],
          [2, 4, 6],
          [3, 7, 9],
          [4, 10, 10]
        ].each do |page, start_nbr, end_nbr|
          context "when the page is #{page}" do
            it "returns #{subject.to_s.downcase}s #{start_nbr} through #{end_nbr}" do
              subject.paginate(page, @per_page).should == @items[(start_nbr - 1)..(end_nbr - 1)]
            end
          end
        end

        context "when the page is 5" do
          it "returns empty" do
            subject.paginate(5, @per_page).should be_empty
          end
        end

        context "when the page is not a positive integer" do
          it "acts as if the page is 1" do
            [-234, 'a', nil].each do |page|
              subject.paginate(page, @per_page).should == @items[0..2]
            end
          end
        end
      end
    end
  end
end

describe Location do
  it_behaves_like "a paginator"
end

describe Ping do
  it_behaves_like "a paginator"
end
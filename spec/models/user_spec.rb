require 'spec_helper'

describe User do
  before do
    @user = User.new
  end

  describe '#new_location' do
    it 'returns a new location' do
      location = Location.new(:title => 'TITLE', :user => @user)
      expect(@user.new_location(:title => 'TITLE')).to eq location
    end
  end

  describe '#paginated_locations_ordered_by_title' do
    def new_location(user, attrs)
      user.new_location({
        :title => 'TITLE',
        :seconds => 20,
        :http_method => 'GET',
        :url => 'http://example.com/',
      }.merge(attrs))
    end

    it do
      locations = [
        new_location(@user, :title => 'B'),
        new_location(@user, :title => 'A'),
        new_location(@user, :title => 'C'),
      ]
      locations.each &:save!

      expect(
        @user.paginated_locations_ordered_by_title(:page => 1, :per_page => 2)
      ).to eq([locations[1], locations[0]])

      expect(@user.paginated_locations_ordered_by_title(:page => 2, :per_page => 2)).to eq([locations[2]])
    end
  end
end
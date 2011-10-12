FactoryGirl.define do
  factory :location do
    seconds 60
    http_method 'get'
    url 'http://example.com'
  end

  factory :ping do
    location
  end
end
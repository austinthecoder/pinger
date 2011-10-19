FactoryGirl.define do
  factory :location do
    title 'Example Home'
    seconds 60
    http_method 'get'
    url 'http://example.com'
  end

  factory :ping do
    location
  end

  factory :email_callback do
    label 'My Email'
    to 'joe@example.com'
  end

  factory :alert do
  end
end
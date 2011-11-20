FactoryGirl.define do
  sequence :title do
    Faker::Lorem.words(rand(2) + 1).join ' '
  end

  sequence :http_method do
    Location::HTTP_METHODS[rand(2)]
  end

  sequence :seconds do
    rand(600) + 30
  end

  factory :location do
    title
    seconds
    http_method
    url 'http://example.com'
  end

  factory :ping do
    location
  end

  factory :email_callback do
    label { FactoryGirl.generate(:title) }
    to 'joe@example.com'
  end

  factory :alert, :class => 'Alert::Record' do
    email_callback
    times { rand(10) + 1 }
    code_is_not { (rand(300) + 200).to_s }
  end
end
# module ModelFactories
#   def build(model, attrs = {})
#     case model
#     when :location
#       Location.build.tap { |l| l.attributes = attributes_for(:location).merge(attrs) }
#     end
#   end

#   def attributes_for(model)
#     case model
#     when :location
#       {
#         :title => Faker::Lorem.words(rand(2) + 1).join(' '),
#         :http_method => Location::HTTP_METHODS[rand(2)],
#         :seconds => (rand(600) + 30),
#         :url => 'http://example.com'
#       }
#     end
#   end
# end

# RSpec.configure do |config|
#   # config.include Factory::Syntax::Methods
#   config.include ModelFactories
# end


RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
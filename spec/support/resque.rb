require 'resque_spec/scheduler'

RSpec.configure do |config|
  config.before(:each) do
    ResqueSpec.reset!
  end
end
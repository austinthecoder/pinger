require 'resque_spec/scheduler'

RSpec.configure do |config|
  config.before { ResqueSpec.reset! }
end
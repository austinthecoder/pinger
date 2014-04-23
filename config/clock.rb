require 'clockwork'

require_relative 'boot'
require_relative 'environment'

Clockwork.every 10.seconds, 'schedule_pings.job' do
  APP.schedule_pings!
end
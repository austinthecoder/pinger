require 'resque_scheduler'
require 'resque/server'

Resque.redis = Redis.new(
  host: CONFIG[:redis][:host],
  port: CONFIG[:redis][:port],
  password: CONFIG[:redis][:password],
  thread_safe: true
)

Resque::Server.use Rack::Auth::Basic do |user, password|
  user == CONFIG[:resque][:web_user] && password == CONFIG[:resque][:web_pass]
end
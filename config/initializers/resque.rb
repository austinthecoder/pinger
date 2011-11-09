require 'resque_scheduler'

Resque.redis = Redis.new(
  host: CONFIG[:resque][:host],
  port: CONFIG[:resque][:port],
  password: CONFIG[:resque][:password],
  thread_safe: true
)

Resque::Server.use Rack::Auth::Basic do |user, password|
  user == CONFIG[:resque][:web_user] && password == CONFIG[:resque][:web_pass]
end
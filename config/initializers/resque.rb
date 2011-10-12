require 'resque_scheduler'

Resque.redis = Redis.new(
  :host => CONFIG[:resque][:host],
  :port => CONFIG[:resque][:port],
  :password => CONFIG[:resque][:password],
  :thread_safe => true
)

# Resque::Server.use(Rack::Auth::Basic) do |user, password|
#   user == "soccer022483" && password == "soccer83"
# end
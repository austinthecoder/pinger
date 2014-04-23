require 'sidekiq/web'

# Sidekiq::Web.use Rack::Auth::Basic do |username, password|
#   username == 'su@routehappy.com' && password == 'flywithme1'
# end

Sidekiq.configure_server do |config|
  config.poll_interval = 1
end
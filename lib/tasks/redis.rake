namespace :redis do
  task :start do
    system('redis-server /usr/local/etc/redis.conf')
  end
end
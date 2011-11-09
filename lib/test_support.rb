module TestSupport
  REDIS_PIDS_DIR = "#{Rails.root}/tmp/pids"
  REDIS_PID = "#{REDIS_PIDS_DIR}/redis-test.pid"
  REDIS_CACHE_PATH = "#{Rails.root}/tmp/cache/"

  class << self
    def start_redis
      `mkdir -p #{REDIS_PIDS_DIR}`
      redis_options = {
        "daemonize" => 'yes',
        "pidfile" => REDIS_PID,
        "port" => CONFIG[:redis][:port],
        "timeout" => 300,
        "save 900" => 1,
        "save 300" => 1,
        "save 60" => 10000,
        "dbfilename" => "dump.rdb",
        "dir" => REDIS_CACHE_PATH,
        "loglevel" => "debug",
        "logfile" => "stdout",
        "databases" => 16
      }.map { |k, v| "#{k} #{v}" }.join '\n'
      `echo '#{redis_options}' | redis-server -`
    end

    def stop_redis
      %x{
        cat #{REDIS_PID} | xargs kill -QUIT
        rm -f #{REDIS_CACHE_PATH}dump.rdb
      }
    end
  end
end
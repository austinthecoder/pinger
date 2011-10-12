require 'test_support'

TestSupport.start_redis
at_exit { TestSupport.stop_redis }
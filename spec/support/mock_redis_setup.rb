# frozen_string_literal: true
require 'mock_redis'

module MockRedisSetup
  def mock_redis_setup
    # clean redis db before each spec
    before(:each) { $redis.redis.flushdb }    
    yield
  end
end
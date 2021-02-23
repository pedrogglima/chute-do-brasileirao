# frozen_string_literal: true

require 'mock_redis'

module MockRedisSetup
  def mock_redis_setup
    # clean redis db before each spec
    redis_conn = redis
    before(:each) { redis_conn.redis.flushdb }
    yield
  end

  protected

  def redis
    Redis.current
  end
end

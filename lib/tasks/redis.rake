# frozen_string_literal: true

namespace :redis do
  # delete all keys
  task flushdb: :environment do
    Redis.current.redis.flushdb
  end
end

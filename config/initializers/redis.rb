# frozen_string_literal: true

# rubocop:disable Layout/LineLength

# Redis#exists(key)` will return an Integer in redis-rb 4.3. `exists?` returns a boolean, you should use it instead. To opt-in to the new behavior now you can set Redis.exists_returns_integer =  true. To disable this message and keep the current (boolean) behaviour of 'exists' you can set `Redis.exists_returns_integer = false`, but this option will be removed in 5.0. (/gems/gems/sidekiq-6.0.7/lib/sidekiq/launcher.rb:160:in `block (2 levels)

# rubocop:enable Layout/LineLength

Redis.exists_returns_integer = false

$redis = Redis.new(host: 'redis_cache', port: 6379)

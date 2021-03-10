# frozen_string_literal: true

require_relative '../base/base_caches'

class ListCaches < BaseCaches
  def initialize(key)
    @key = key
  end

  def get(from = 0, to = -1)
    redis.lrange(@key, from, to)
  end

  def set(
    resources,
    partial_path,
    partial_resource_as = 'resource',
    expire = 3600
  )
    resources.each do |resource|
      redis.rpush(
        @key,
        stringify_partial(resource, partial_path, partial_resource_as)
      )
    end

    redis.expire(@key, expire) if expire
  end
end

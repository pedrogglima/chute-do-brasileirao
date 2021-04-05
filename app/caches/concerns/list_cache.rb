# frozen_string_literal: true

require 'base_cache'

class ListCache < BaseCache
  attr_reader :key

  def initialize(key)
    @key = key
  end

  def get(from = 0, to = -1)
    redis.lrange(key, from, to)
  end

  def set(
    resources,
    partial_path,
    partial_resource_as = 'resource',
    expire = 3600
  )
    resources.each do |resource|
      redis.rpush(
        key,
        stringify_partial(resource, partial_path, partial_resource_as)
      )
    end

    redis.expire(key, expire) if expire
  end

  def set_reverse(
    resources,
    partial_path,
    partial_resource_as = 'resource',
    expire = 3600
  )
    resources.each do |resource|
      redis.lpush(
        key,
        stringify_partial(resource, partial_path, partial_resource_as)
      )
    end

    redis.expire(key, expire) if expire
  end

  def del
    redis.del key
  end
end

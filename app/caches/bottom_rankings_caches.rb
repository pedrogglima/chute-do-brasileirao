# frozen_string_literal: true

require_relative 'partials/list_caches'

class BottomRankingsCaches < ListCaches
  KEY = 'bottom_rankings_list'

  def initialize
    super(KEY)
  end

  def set(
    resources,
    partial_path,
    partial_resource_as = 'resource',
    expire = 3600
  )
    resources.each do |resource|
      redis.lpush(
        @key,
        stringify_partial(resource, partial_path, partial_resource_as)
      )
    end

    redis.expire(@key, expire) if expire
  end
end

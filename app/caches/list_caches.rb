# frozen_string_literal: true

class ListCaches < BaseCaches
  attr_reader :list, :from, :to

  def initialize(key, from = 0, to = -1)
    @key = "#{key}_list"
    @from = from
    @to = to

    @list = get(@from, @to)
  end

  def cached?
    !@list.empty?
  end

  def get(from = 0, to = -1)
    redis.lrange(@key, from, to).map do |raw_resource|
      JSON.parse(raw_resource).with_indifferent_access
    end
  end

  def set(resources, expire = 3600)
    resources.each do |resource|
      redis.rpush(@key, to_json(resource))
    end

    redis.expire(@key, expire) if expire

    @list = get(@from, @to)
  end
end

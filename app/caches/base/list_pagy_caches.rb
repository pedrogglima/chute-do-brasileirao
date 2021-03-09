# frozen_string_literal: true

require_relative 'base_caches'

class ListPagyCaches < BaseCaches
  attr_reader :from, :to
  
  def initialize(key, key_pagy, from, to)
    @key = key
    @key_pagy = key_pagy
    @from = from
    @to = to

    @list, @pagy = get(@from, @to)
  end

  def cached?
    !@list.empty? && @pagy
  end

  def get(from = 0, to = -1)
    [fetch_list(from, to), fetch_pagy]
  end

  def set(resources, pagy, expire = 3600)
    load_list(resources)
    load_pagy(pagy)

    expire_resources(expire) if expire

    @list, @pagy = get(@from, @to)
  end

  protected

  def pagy_to_json(pagy)
    {
      page: pagy.page,
      pages: pagy.pages,
      last: pagy.last,
      items: pagy.items,
      count: pagy.count
    }.to_json
  end

  private

  def fetch_list(from, to)
    redis.lrange(@key, from, to).map do |raw_resource|
      JSON.parse(raw_resource).with_indifferent_access
    end
  end

  def fetch_pagy
    res = redis.get(@key_pagy)
    return unless res

    JSON.parse(res).with_indifferent_access
  end

  def load_list(resources)
    resources.each do |resource|
      redis.rpush(@key, to_json(resource))
    end
  end

  def load_pagy(val)
    redis.set(@key_pagy, pagy_to_json(val))
  end

  def expire_resources(expire)
    redis.expire(@key, expire)
    redis.expire(@key_pagy, expire)
  end
end

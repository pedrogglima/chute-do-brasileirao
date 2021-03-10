# frozen_string_literal: true

require_relative '../base/base_caches'

class ListPagyCaches < BaseCaches
  attr_reader :from, :to

  def initialize(key, key_pagy)
    @key = key
    @key_pagy = key_pagy
  end

  def get(from = 0, to = -1)
    [fetch_pagy, fetch_list(from, to)]
  end

  def set(resources, pagy, partial_path, partial_resource_as, expire = 3600)
    load_list(resources, partial_path, partial_resource_as)
    load_pagy(pagy)

    expire_resources(expire) if expire
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
    redis.lrange(@key, from, to)
  end

  def fetch_pagy
    res = redis.get(@key_pagy)
    return unless res

    JSON.parse(res).with_indifferent_access
  end

  def load_list(resources, partial_path, partial_resource_as = 'resources')
    resources.each do |resource|
      redis.rpush(
        @key,
        stringify_partial(resource, partial_path, partial_resource_as)
      )
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

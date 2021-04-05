# Cache

Classes found on folder concerns offer encapsulation, with some adaptions, for Redis DB calls.
Classes found on folder concerns that inherit from BaseCache must agree with module Cacheable.
Classes outside concerns define the object that will be cached.

Note: classes outside folder concerns must

- declare constant KEY to allow only one instance exist on Redis DB.
- extend concerns/Cacheable and implement the method cache, which must returns a object that respond to Cacheable API.

Exemple:

    require_relative 'concerns/list_cacheable'
    require_relative 'concerns/handle_logic_for_redis_calls_cache'

    class ObjectCache
      # Offers a interface for the common methods #get, #set, #del
      # expects #cache be implemented
      extend ListCacheable

      KEY = 'object_cache'

      class << self
        def cache
          @cache ||= HandleLogicForRedisCalls.new(KEY)
        end
      end
    end

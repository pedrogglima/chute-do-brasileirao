# frozen_string_literal: true

require_relative 'concerns/list_cacheable'
require_relative 'concerns/list_pagy_cache'

class PreviousMatchesCache
  extend ListCacheable

  KEY = 'previous_matches_list'
  KEY_PAGY = 'previous_matches_list_pagy'

  class << self
    def cache
      @cache = ListPagyCache.new(KEY, KEY_PAGY)
    end
  end
end

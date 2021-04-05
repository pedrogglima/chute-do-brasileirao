# frozen_string_literal: true

require_relative 'concerns/list_cacheable'
require_relative 'concerns/list_cache'

class BottomRankingsCache
  extend ListCacheable

  KEY = 'bottom_rankings_list'

  class << self
    def cache
      @cache ||= ListCache.new(KEY)
    end
  end
end

# frozen_string_literal: true

require_relative 'concerns/list_cacheable'
require_relative 'concerns/list_cache'

class TodayMatchesCache
  extend ListCacheable

  KEY = 'today_matches_list'

  class << self
    def cache
      @cache ||= ListCache.new(KEY)
    end
  end
end

# frozen_string_literal: true

module Cache
  class TopRankingsService < Cache::RankingsService
    KEY = 'ranking_list'
    FROM = 0
    TO = 6

    def call
      res = list(KEY, FROM, TO)

      return res unless res.empty?

      load_resources(KEY)
      list(KEY, FROM, TO)
    end
  end
end

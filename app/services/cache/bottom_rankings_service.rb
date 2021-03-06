# frozen_string_literal: true

module Cache
  class BottomRankingsService < Cache::RankingsService
    KEY = 'ranking_list'
    FROM = 16
    TO = 19

    def call
      res = list(KEY, FROM, TO)

      return res unless res.empty?

      load_resources(KEY)
      list(KEY, FROM, TO)
    end
  end
end

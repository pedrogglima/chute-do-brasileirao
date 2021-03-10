# frozen_string_literal: true

require_relative 'partials/list_caches'

class TopRankingsCaches < ListCaches
  KEY = 'top_rankings_list'

  def initialize
    super(KEY)
  end
end

# frozen_string_literal: true

require_relative 'partials/list_caches'

class RankingsCaches < ListCaches
  KEY = 'rankings_list'

  def initialize
    super(KEY)
  end
end

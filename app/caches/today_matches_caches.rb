# frozen_string_literal: true

require_relative 'partials/list_caches'

class TodayMatchesCaches < ListCaches
  KEY = 'today_matches_list'

  def initialize
    super(KEY)
  end
end

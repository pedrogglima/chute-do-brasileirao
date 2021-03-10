# frozen_string_literal: true

require_relative 'partials/list_pagy_caches'

class NextMatchesCaches < ListPagyCaches
  KEY = 'next_matches_list'
  KEY_PAGY = 'next_matches_list_pagy'

  def initialize
    super(KEY, KEY_PAGY)
  end
end

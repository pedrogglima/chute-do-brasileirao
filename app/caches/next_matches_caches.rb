# frozen_string_literal: true

require_relative 'base/list_pagy_caches'

class NextMatchesCaches < ListPagyCaches
  KEY = 'next_matches_list'
  KEY_PAGY = 'next_matches_list_pagy'

  def initialize(from = 0, to = -1)
    super(KEY, KEY_PAGY, from, to)
  end

  private

  def to_json(match)
    {
      id: match.id,
      date: match.date,
      id_match: match.id_match,
      team_avatar: extract_blob_url(match.team.avatar),
      team_name: match.team.name,
      opponent_avatar: extract_blob_url(match.opponent.avatar),
      opponent_name: match.opponent.name,
      place: match.place
    }.to_json
  end
end

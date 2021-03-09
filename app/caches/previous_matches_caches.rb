# frozen_string_literal: true

require_relative 'base/list_pagy_caches'

class PreviousMatchesCaches < ListPagyCaches
  KEY = 'previous_matches_list'
  KEY_PAGY = 'previous_matches_list_pagy'

  def initialize(from = 0, to = -1)
    super(KEY, KEY_PAGY, from, to)
  end

  private

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def to_json(match)
    {
      id: match.id,
      date: match.date,
      id_match: match.id_match,
      team_avatar: extract_blob_url(match.team.avatar),
      team_name: match.team.name,
      team_score: match.team_score,
      opponent_avatar: extract_blob_url(match.opponent.avatar),
      opponent_name: match.opponent.name,
      opponent_score: match.opponent_score,
      place: match.place
    }.to_json
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize
end

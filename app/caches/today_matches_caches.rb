# frozen_string_literal: true

require_relative 'base/list_caches'

class TodayMatchesCaches < ListCaches
  KEY = 'today_matches_list'

  def initialize(from = 0, to = -1)
    super(KEY, from, to)
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
      opponent_avatar: extract_blob_url(match.opponent.avatar),
      opponent_name: match.opponent.name,
      place: match.place,
      update_at: match.updated_at
    }.to_json
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize
end

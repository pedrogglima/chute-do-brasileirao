# frozen_string_literal: true

class TodayMatchesCaches < ListCaches
  def initialize(key = 'today_matches', from = 0, to = -1)
    super
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

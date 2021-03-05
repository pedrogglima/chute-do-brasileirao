# frozen_string_literal: true

class NextMatchesCaches < ListPagyCaches
  def initialize(key = 'next_matches', from = 0, to = -1)
    super
  end

  private

  def to_json(match)
    {
      id: match.id,
      date: match.date,
      id_match: match.id_match,
      team_avatar: extract_url(match.team.avatar),
      team_name: match.team.name,
      opponent_avatar: extract_url(match.opponent.avatar),
      opponent_name: match.opponent.name,
      place: match.place
    }.to_json
  end
end

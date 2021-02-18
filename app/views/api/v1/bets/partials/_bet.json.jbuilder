# frozen_string_literal: true
json.call(
  bet,
  :id,
  :bet_team_score,
  :bet_opponent_score
)

json.match do
  json.partial!('api/v1/matches/partials/match', match: bet.match)
end

# frozen_string_literal: true
json.call(
  match,
  :id,
  :id_match,
  :team_score,
  :opponent_score,
  :date,
  :place,
  :number_of_changes
)

json.championship do
  json.partial!('api/v1/championships/partials/championship', championship: match.championship)
end

json.team do
  json.partial!('api/v1/teams/partials/team', team: match.team)
end

json.opponent do
  json.partial!('api/v1/teams/partials/team', team: match.opponent)
end

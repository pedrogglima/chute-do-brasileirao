# frozen_string_literal: true
json.call(
  ranking,
  :id,
  :posicao,
  :pontos
)

json.team do
  json.partial!('api/v1/teams/partials/team', team: ranking.team)
end

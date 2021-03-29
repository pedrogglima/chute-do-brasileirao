# frozen_string_literal: true

json.call(
  ranking,
  :id,
  :position,
  :points,
  :played,
  :won,
  :drawn,
  :lost,
  :goals_for,
  :goals_against,
  :goal_difference,
  :yellow_card,
  :red_card,
  :advantages,
  :form
)

json.team do
  json.partial!('api/v1/teams/partials/team', team: ranking.team)
end

json.next_opponent do
  json.partial!('api/v1/teams/partials/team', team: ranking.next_opponent)
end

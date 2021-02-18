# frozen_string_literal: true
json.call(
  championship,
  :id,
  :year,
  :number_of_participants
)

json.league do
  json.partial!('api/v1/leagues/partials/league', league: championship.league)
end

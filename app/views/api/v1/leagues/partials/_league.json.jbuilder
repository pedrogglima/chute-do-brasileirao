# frozen_string_literal: true
json.call(
  league,
  :id,
  :name
)

json.division do
  json.partial!('api/v1/divisions/partials/division', division: league.division)
end

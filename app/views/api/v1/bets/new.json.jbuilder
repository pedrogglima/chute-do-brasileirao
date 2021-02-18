# frozen_string_literal: true
json.bet do
  json.match do
    json.partial!('api/v1/matches/partials/match', match: @match)
  end
end

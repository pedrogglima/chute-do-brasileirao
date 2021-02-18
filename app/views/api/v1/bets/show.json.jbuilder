# frozen_string_literal: true
json.bet do
  json.partial!('api/v1/bets/partials/bet', bet: @bet)
end

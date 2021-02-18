# frozen_string_literal: true

json.data do
  json.user do
    json.partial!('api/v1/users/partials/user', user: current_user)
  end
  json.bets do
    json.array!(@bets) do |bet|
      json.bet do
        json.partial!('api/v1/bets/partials/bet', bet: bet)
      end
    end
  end
end

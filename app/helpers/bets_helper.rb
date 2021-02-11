# frozen_string_literal: true
module BetsHelper
  def format_bet_score(bet_team_score, bet_opponent_score)
    if bet_team_score && bet_opponent_score
      "#{bet_team_score} x #{bet_opponent_score}"
    end
  end
end

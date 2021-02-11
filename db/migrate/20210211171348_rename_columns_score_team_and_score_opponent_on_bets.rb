# frozen_string_literal: true
class RenameColumnsScoreTeamAndScoreOpponentOnBets < ActiveRecord::Migration[6.1]
  def change
    rename_column(:bets, :score_team, :bet_team_score)
    rename_column(:bets, :score_opponent, :bet_opponent_score)
  end
end

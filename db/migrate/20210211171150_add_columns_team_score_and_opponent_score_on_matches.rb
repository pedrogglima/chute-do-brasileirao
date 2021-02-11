# frozen_string_literal: true
class AddColumnsTeamScoreAndOpponentScoreOnMatches < ActiveRecord::Migration[6.1]
  def change
    add_column(:matches, :team_score, :integer, null: true)
    add_column(:matches, :opponent_score, :integer, null: true)
  end
end

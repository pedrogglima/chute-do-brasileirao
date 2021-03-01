# frozen_string_literal: true

class UpdateNextOpponentNullTrueToRankings < ActiveRecord::Migration[6.1]
  def change
    change_column_null :rankings, :next_opponent_id, true
  end
end

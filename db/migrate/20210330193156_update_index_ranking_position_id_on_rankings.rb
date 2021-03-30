# frozen_string_literal: true

class UpdateIndexRankingPositionIdOnRankings < ActiveRecord::Migration[6.1]
  def change
    remove_index :rankings, name: 'index_rankings_on_[:championship_id, :position]_id'
    add_index :rankings, %i[championship_id position], unique: true
  end
end

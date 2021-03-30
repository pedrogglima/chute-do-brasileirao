# frozen_string_literal: true

class RemoveUncessaryColumnOnRankings < ActiveRecord::Migration[6.1]
  def change
    remove_column :rankings, '[:championship_id, :id_match]_id'
  end
end

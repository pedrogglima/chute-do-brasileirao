# frozen_string_literal: true

class RemoveUnecessaryColumnOnRankings < ActiveRecord::Migration[6.1]
  def change
    remove_column :rankings, '[:championship_id, :position]_id'
  end
end

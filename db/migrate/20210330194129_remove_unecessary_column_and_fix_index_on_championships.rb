# frozen_string_literal: true

class RemoveUnecessaryColumnAndFixIndexOnChampionships < ActiveRecord::Migration[6.1]
  def change
    remove_column :championships, '[:league_id, :year]_id'
    add_index :championships, :year, unique: true
  end
end

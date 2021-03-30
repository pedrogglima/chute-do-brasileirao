# frozen_string_literal: true

class RemoveUnecessaryColumnAndFixIndexOnRounds < ActiveRecord::Migration[6.1]
  def change
    remove_column :rounds, '[:championship_id, :number]_id'
    add_index :rounds, %i[championship_id number], unique: true
  end
end

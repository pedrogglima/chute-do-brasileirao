# frozen_string_literal: true

class RemoveUncessaryIndex < ActiveRecord::Migration[6.1]
  def change
    remove_index :rankings, name: 'index_rankings_on_[:championship_id, :id_match]_id'
  end
end

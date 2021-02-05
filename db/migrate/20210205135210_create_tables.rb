# frozen_string_literal: true
class CreateTables < ActiveRecord::Migration[6.1]
  def change
    create_table :tables do |t|
      t.references(:league, null: false, foreign_key: true)
      t.date(:year)
      t.integer(:number_of_participants)
      t.timestamps
    end
    add_index(:tables, [:league_id, :year], unique: true)
  end
end

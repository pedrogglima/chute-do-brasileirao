# frozen_string_literal: true
class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.references(:table, null: false, foreign_key: true)
      t.references(:team, null: false, foreign_key: true)
      t.references(:opponent, null: false, foreign_key: { to_table: :teams })
      t.string(:identification, null: false)
      t.string(:number_of_changes, null: true)
      t.string(:place, null: true)
      t.datetime(:date, null: true)
      t.string(:score, null: true)
      t.timestamps
    end
    add_index(:matches, :date, unique: false)
  end
end

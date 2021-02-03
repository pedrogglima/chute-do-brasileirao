# frozen_string_literal: true
class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.string(:name, null: false)
      t.string(:state)
      t.timestamps
    end

    add_index(:teams, :name, unique: true)
  end
end

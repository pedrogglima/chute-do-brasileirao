# frozen_string_literal: true
class CreateConfigurations < ActiveRecord::Migration[6.1]
  def change
    create_table :configurations do |t|
      t.references(:championship, null: false, foreign_key: true)
      t.integer(:singleton_guard, null: false, default: 0)
      t.timestamps
    end
    add_index(:configurations, :singleton_guard, unique: true)
  end
end

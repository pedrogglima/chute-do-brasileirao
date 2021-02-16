# frozen_string_literal: true
class CreateGlobalSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :global_settings do |t|
      t.references(:championship, null: true, foreign_key: true)
      t.integer(:singleton_guard, null: false, default: 0)
      t.timestamps
    end
    add_index(:global_settings, :singleton_guard, unique: true)
  end
end

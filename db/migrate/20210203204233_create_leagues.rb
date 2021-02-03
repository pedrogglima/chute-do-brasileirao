# frozen_string_literal: true
class CreateLeagues < ActiveRecord::Migration[6.1]
  def change
    create_table :leagues do |t|
      t.string(:name, null: false)
      t.string(:division)
      t.timestamps
    end
    add_index(:leagues, [:name, :division], unique: true)
  end
end

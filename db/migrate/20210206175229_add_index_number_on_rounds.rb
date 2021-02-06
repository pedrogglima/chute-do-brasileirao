# frozen_string_literal: true
class AddIndexNumberOnRounds < ActiveRecord::Migration[6.1]
  def change
    add_reference(:rounds, [:championship_id, :number], unique: true)
  end
end

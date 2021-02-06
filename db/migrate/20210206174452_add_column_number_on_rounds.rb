# frozen_string_literal: true
class AddColumnNumberOnRounds < ActiveRecord::Migration[6.1]
  def change
    add_column(:rounds, :number, :integer, null: false)
  end
end

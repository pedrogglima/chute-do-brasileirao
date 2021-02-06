# frozen_string_literal: true
class AddRoundToMatches < ActiveRecord::Migration[6.1]
  def change
    add_reference(:matches, :round, null: false, foreign_key: true)
  end
end

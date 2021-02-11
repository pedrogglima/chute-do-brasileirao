# frozen_string_literal: true
class RemoveColumnScoreOnMatches < ActiveRecord::Migration[6.1]
  def change
    remove_column(:matches, :score)
  end
end

# frozen_string_literal: true
class AddIndexUniqueToPositionOnRankings < ActiveRecord::Migration[6.1]
  def change
    add_reference(:rankings, [:championship_id, :position], unique: true)
  end
end

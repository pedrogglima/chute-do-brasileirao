# frozen_string_literal: true
class AddColumnYearOnChampionships < ActiveRecord::Migration[6.1]
  def change
    add_column(:championships, :year, :integer, null: false)
    add_reference(:championships, [:league_id, :year], unique: true)
  end
end

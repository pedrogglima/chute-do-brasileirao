# frozen_string_literal: true
class RemoveColumnYearOnChampionships < ActiveRecord::Migration[6.1]
  def change
    remove_column(:championships, :year)
  end
end

# frozen_string_literal: true
class RenameColumnTableToChampionshipOnMatches < ActiveRecord::Migration[6.1]
  def change
    rename_column(:matches, :table_id, :championship_id)
  end
end

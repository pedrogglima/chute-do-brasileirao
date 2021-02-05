class RenameTableTableToChampionship < ActiveRecord::Migration[6.1]
  def change
    rename_table "tables", "championships"
  end
end

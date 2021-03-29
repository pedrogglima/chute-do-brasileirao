# frozen_string_literal: true

class UpdateMatchesToMatchWithScrapCbfMatch < ActiveRecord::Migration[6.1]
  def change
    rename_column :matches, :number_of_changes, :updates
    add_column :matches, :start_at, :string
  end
end

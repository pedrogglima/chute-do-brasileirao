# frozen_string_literal: true
class RenameColumnIdentificationToIdMatchOnMatch < ActiveRecord::Migration[6.1]
  def change
    rename_column(:matches, :identification, :id_match)
  end
end

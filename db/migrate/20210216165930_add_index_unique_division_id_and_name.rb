# frozen_string_literal: true
class AddIndexUniqueDivisionIdAndName < ActiveRecord::Migration[6.1]
  def change
    add_index(:leagues, [:division_id, :name], unique: true)
  end
end

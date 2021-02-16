# frozen_string_literal: true
class RemoveColumnDivisionOnLeagues < ActiveRecord::Migration[6.1]
  def change
    remove_column(:leagues, :division)
  end
end

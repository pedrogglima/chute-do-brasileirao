# frozen_string_literal: true
class DeleteTableConfigurations < ActiveRecord::Migration[6.1]
  def change
    drop_table(:configurations)
  end
end

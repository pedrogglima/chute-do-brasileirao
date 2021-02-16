# frozen_string_literal: true
class ChangeOptionNullToFalseOnGlobalSettings < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:global_settings, :championship_id, false)
  end
end

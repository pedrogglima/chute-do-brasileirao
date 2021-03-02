# frozen_string_literal: true

class AddGrantedPeriodToGlobalSettings < ActiveRecord::Migration[6.1]
  def change
    add_column :global_settings,
               :granted_period,
               :integer,
               null: false,
               default: 3
  end
end

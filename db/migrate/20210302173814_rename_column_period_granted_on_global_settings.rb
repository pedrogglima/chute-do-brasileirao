# frozen_string_literal: true

class RenameColumnPeriodGrantedOnGlobalSettings < ActiveRecord::Migration[6.1]
  def change
    rename_column :global_settings,
                  :granted_period,
                  :days_of_scraping_after_finished
  end
end

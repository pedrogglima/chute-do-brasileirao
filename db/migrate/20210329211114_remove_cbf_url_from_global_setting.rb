# frozen_string_literal: true

class RemoveCbfUrlFromGlobalSetting < ActiveRecord::Migration[6.1]
  def change
    remove_column :global_settings, :cbf_url
  end
end

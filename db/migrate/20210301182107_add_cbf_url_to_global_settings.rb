class AddCbfUrlToGlobalSettings < ActiveRecord::Migration[6.1]
  def change
    add_column :global_settings, :cbf_url, :string
  end
end

# frozen_string_literal: true

class AddOminauthToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :provider, :string
  end
end

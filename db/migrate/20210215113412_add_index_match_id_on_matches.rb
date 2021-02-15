# frozen_string_literal: true
class AddIndexMatchIdOnMatches < ActiveRecord::Migration[6.1]
  def change
    add_index(:matches, [:championship_id, :id_match], unique: true)
    # Ex:- add_index("admin_users", "username")
  end
end

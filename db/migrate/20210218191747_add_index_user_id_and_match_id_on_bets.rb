# frozen_string_literal: true
class AddIndexUserIdAndMatchIdOnBets < ActiveRecord::Migration[6.1]
  def change
    add_index(:bets, [:user_id, :match_id], unique: true)
    # Ex:- add_index("admin_users", "username")
  end
end

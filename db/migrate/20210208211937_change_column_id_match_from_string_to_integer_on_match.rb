# frozen_string_literal: true
class ChangeColumnIdMatchFromStringToIntegerOnMatch < ActiveRecord::Migration[6.1]
  def change
    change_column(:matches, :id_match, :integer, using: 'id_match::integer', null: false)
    # Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end

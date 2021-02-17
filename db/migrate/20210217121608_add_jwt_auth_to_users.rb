# frozen_string_literal: true
class AddJwtAuthToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column(:users, :uid, :string)
    add_column(:users, :jti, :string)
    add_index(:users, :jti)
  end
end

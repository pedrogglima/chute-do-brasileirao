# frozen_string_literal: true
class AddColumnAvatarUrlToTeams < ActiveRecord::Migration[6.1]
  def change
    add_column(:teams, :avatar_url, :string)
  end
end

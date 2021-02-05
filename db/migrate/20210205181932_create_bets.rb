# frozen_string_literal: true
class CreateBets < ActiveRecord::Migration[6.1]
  def change
    create_table :bets do |t|
      t.references(:user, null: false, foreign_key: true)
      t.references(:match, null: false, foreign_key: true)
      t.integer(:score_team, null: false, default: 0)
      t.integer(:score_opponent, null: false, default: 0)
      t.timestamps
    end
  end
end

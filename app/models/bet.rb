# frozen_string_literal: true
class Bet < ApplicationRecord
  belongs_to :user
  belongs_to :match

  validates :bet_team_score,
            presence: true,
            numericality: { only_integer: true },
            inclusion: 0..100

  validates :bet_opponent_score,
            presence: true,
            numericality: { only_integer: true },
            inclusion: 0..100
end

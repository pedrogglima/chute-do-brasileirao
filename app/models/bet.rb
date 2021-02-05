# frozen_string_literal: true
class Bet < ApplicationRecord
  belongs_to :user
  belongs_to :match

  validates :score_team,
            presence: true,
            numericality: { only_integer: true },
            inclusion: 0..100

  validates :score_opponent,
            presence: true,
            numericality: { only_integer: true },
            inclusion: 0..100
end

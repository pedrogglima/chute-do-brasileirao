# frozen_string_literal: true
class Match < ApplicationRecord
  belongs_to :championship
  belongs_to :round
  belongs_to :team
  belongs_to :opponent, class_name: "Team", foreign_key: "opponent_id"

  validates :id_match,
            presence: true,
            uniqueness: { scope: :championship_id },
            numericality: { only_integer: true },
            inclusion: 1..380

  validates :team_score,
            numericality: { only_integer: true },
            inclusion: 0..100,
            allow_nil: true

  validates :opponent_score,
            numericality: { only_integer: true },
            inclusion: 0..100,
            allow_nil: true
end

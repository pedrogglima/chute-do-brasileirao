# frozen_string_literal: true
class Bet < ApplicationRecord
  # associations
  #
  belongs_to :user
  belongs_to :match

  # validations
  #
  validates :bet_team_score,
            presence: true,
            numericality: { only_integer: true },
            inclusion: 0..100

  validates :bet_opponent_score,
            presence: true,
            numericality: { only_integer: true },
            inclusion: 0..100

  # scopes
  #
  scope :matches_with_teams, -> {
                               includes(match: [
                                 team: { avatar_attachment: :blob },
                                 opponent: { avatar_attachment: :blob },
                               ])
                             }
end

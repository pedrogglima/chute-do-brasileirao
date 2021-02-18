# frozen_string_literal: true
class Bet < ApplicationRecord
  # associations
  #
  belongs_to :user
  belongs_to :match

  # validations
  #
  validates :user_id, uniqueness: { scope: :match_id }

  validates :bet_team_score,
            presence: true,
            numericality: { only_integer: true },
            inclusion: 0..100

  validates :bet_opponent_score,
            presence: true,
            numericality: { only_integer: true },
            inclusion: 0..100

  validate :creation_period, on: :create

  # scopes
  #
  scope :matches_relationships, -> {
    joins(match: { championship: { league: :division } })
  }
  scope :matches_with_teams, -> {
                               includes(match: [
                                 team: { avatar_attachment: :blob },
                                 opponent: { avatar_attachment: :blob },
                               ])
                             }

  private

  # Validates whether user can bet or not, based on the match schedule.
  # User can only bet on the same date of the match and before it start.
  #
  def creation_period
    if match
      if match.already_played?
        errors.add(:base, 'O período para chute dessa partida já expirou.')
      elsif !match.today?
        errors.add(:base, 'O período para chute dessa partida não iníciou.')
      end
    end
  end
end

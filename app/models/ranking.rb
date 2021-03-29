# frozen_string_literal: true

class Ranking < ApplicationRecord
  # associations
  #
  belongs_to :championship
  belongs_to :team
  belongs_to :next_opponent,
             class_name: 'Team',
             foreign_key: 'next_opponent_id',
             optional: true

  # validations
  #
  validates :position,
            presence: true,
            numericality: { only_integer: true },
            inclusion: 1..20
  validates :points, presence: true
  validates :played, presence: true
  validates :won, presence: true
  validates :drawn, presence: true
  validates :lost, presence: true
  validates :goals_for, presence: true
  validates :goals_against, presence: true
  validates :goal_difference, presence: true
  validates :yellow_card, presence: true
  validates :red_card, presence: true
  validates :advantages, presence: true

  # scopes
  #
  scope :top_rank, -> { limit(6) }
  scope :bottom_rank, -> { limit(4) }
  # To avoid n+1 issue
  scope :championship_relationships, lambda {
    joins(championship: { league: :division })
  }
  scope :team_with_avatar, -> { includes(team: { avatar_attachment: :blob }) }
  # There are cases where there aren`t next opponents
  scope :next_opponent_with_avatar, lambda {
    left_outer_joins(:next_opponent)
      .includes(next_opponent: { avatar_attachment: :blob })
  }
end

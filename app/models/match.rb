# frozen_string_literal: true

class Match < ApplicationRecord
  # associations
  #
  belongs_to :championship
  belongs_to :round
  belongs_to :team
  belongs_to :opponent, class_name: 'Team', foreign_key: 'opponent_id'

  # validations
  #
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

  # scopes
  #
  scope :today_matches, -> { where(date: Date.today.all_day) }
  scope :next_matches, ->(date) { where('date >= ? OR date IS ?', date, nil) }
  scope :previous_matches, ->(date) { where('date <= ?', date) }
  scope :dated_matches, -> { where.not(date: nil) }
  scope :last_dated_match, lambda {
    where.not(date: nil).order(date: :desc).limit(1).first
  }
  # To avoid n+1 issue
  scope :team_with_avatar, -> { includes(team: { avatar_attachment: :blob }) }
  scope :opponent_with_avatar, lambda {
    includes(opponent: { avatar_attachment: :blob })
  }

  def today?
    date&.to_date == Date.today
  end

  def already_played?
    date.present? && date < Time.now ? true : false
  end
end

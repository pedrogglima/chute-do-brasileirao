# frozen_string_literal: true

class Championship < ApplicationRecord
  # associations
  #
  belongs_to :league
  has_many :matches
  has_many :rankings

  # validations
  #
  validates :year,
            presence: true,
            uniqueness: { scope: :league_id },
            numericality: { only_integer: true },
            inclusion: 2020..3000

  validates :number_of_participants,
            presence: true,
            numericality: { only_integer: true },
            inclusion: 1..1000

  validates :number_of_matches,
            presence: true,
            numericality: { only_integer: true }

  # public methods
  #
  def finished?
    return false unless count_dated_matches == number_of_matches

    diff_date(time_now, last_dated_match.date) >= granted_period
  end

  def count_dated_matches
    matches.dated_matches.count
  end

  def last_dated_match
    matches.last_dated_match
  end

  private

  def time_now
    Time.current
  end

  def granted_period
    259_200 # 3 days in seconds
  end

  def diff_date(date1, date2)
    (date1 - date2).to_i
  end
end

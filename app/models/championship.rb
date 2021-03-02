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
    if count_dated_matches == number_of_matches &&
       last_match_already_played?
      true
    else
      false
    end
  end

  def last_match_already_played?
    last_dated_match.date < Time.current
  end

  def count_dated_matches
    matches.dated_matches.count
  end

  def last_dated_match
    matches.last_dated_match
  end
end

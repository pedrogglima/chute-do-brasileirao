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
end

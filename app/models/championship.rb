# frozen_string_literal: true
class Championship < ApplicationRecord
  belongs_to :league

  validates :year, presence: true, uniqueness: { scope: :league_id }
  validates :number_of_participants,
            presence: true,
            numericality: { only_integer: true },
            inclusion: 1..1000
end

# frozen_string_literal: true
class Round < ApplicationRecord
  # associations
  #
  belongs_to :championship
  has_many :matches

  # validations
  #
  validates :number,
            presence: true,
            uniqueness: { scope: :championship_id },
            numericality: { only_integer: true },
            inclusion: 1..38
end

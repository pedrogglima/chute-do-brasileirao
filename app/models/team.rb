# frozen_string_literal: true
class Team < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: true,
            length: { within: 1..100 }

  validates :state,
            presence: true,
            length: { within: 1..2 }
end

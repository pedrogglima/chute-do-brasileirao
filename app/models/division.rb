# frozen_string_literal: true

class Division < ApplicationRecord
  # associations
  #
  has_many :leagues

  # validations
  #
  validates :name,
            presence: true,
            uniqueness: true,
            length: { within: 1..100 }
end

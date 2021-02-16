# frozen_string_literal: true
class Division < ApplicationRecord
  has_many :leagues

  validates :name,
            presence: true,
            uniqueness: true,
            length: { within: 1..100 }
end

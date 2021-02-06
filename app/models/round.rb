# frozen_string_literal: true
class Round < ApplicationRecord
  belongs_to :championship
  has_many :matches
end

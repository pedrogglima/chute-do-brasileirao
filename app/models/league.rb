# frozen_string_literal: true

class League < ApplicationRecord
  # associations
  #
  has_many :championships
  belongs_to :division

  # validations
  #
  validates :name,
            presence: true,
            uniqueness: { scope: :division_id },
            length: { within: 1..100 }

  validates :division,
            presence: false,
            length: { maximum: 100 }
end

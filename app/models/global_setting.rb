# frozen_string_literal: true

class GlobalSetting < ApplicationRecord
  # associations
  #
  # This references the current championship used on the app.
  belongs_to :championship

  # validations
  #
  validates :singleton_guard,
            presence: true,
            uniqueness: true,
            numericality: { only_integer: true },
            inclusion: [0]

  # class methods
  #
  def self.singleton
    first_or_create!(singleton_guard: 0)
  end
end

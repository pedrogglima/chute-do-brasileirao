# frozen_string_literal: true
class GlobalSetting < ApplicationRecord
  # This references the current championship used on the app.
  belongs_to :championship, optional: true

  validates :singleton_guard,
            presence: true,
            uniqueness: true,
            numericality: { only_integer: true },
            inclusion: [0]

  def self.singleton
    first_or_create!(singleton_guard: 0)
  end
end

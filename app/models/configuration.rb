# frozen_string_literal: true

# Singleton class
# This class holds in a single place the configs for the app
# How to use: Configuration.instance.attr_name
#
class Configuration < ApplicationRecord
  validates :singleton_guard,
            presence: true,
            uniqueness: true,
            numericality: { only_integer: true },
            inclusion: [0]

  # This references the current championship used on the app.
  belongs_to :championship

  def self.instance
    first_or_create!(singleton_guard: 0)
  end
end

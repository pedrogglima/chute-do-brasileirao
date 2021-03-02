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

  # e.g 'https://www.cbf.com.br/futebol-brasileiro/competicoes/campeonato-brasileiro-serie-a'
  validates :cbf_url,
            presence: true

  # specify how many days the app should scrap the CBF after the last match
  validates :granted_period,
            presence: true,
            numericality: { only_integer: true }

  # class methods
  #
  def self.singleton
    first_or_create!(singleton_guard: 0)
  end

  # public methods
  #
  def url_current_championship
    "#{cbf_url}/#{championship.year}"
  end

  def granted_period_in_seconds
    granted_period * 1.day.seconds
  end
end

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

  # period to scrap after championship finished
  validates :days_of_scraping_after_finished,
            presence: true,
            numericality: { only_integer: true },
            inclusion: 1..100

  # class methods
  #
  def self.singleton
    first_or_create!(singleton_guard: 0)
  end

  def continuing_scraping?
    if championship.finished? && period_for_scraping_finished?
      false
    else
      true
    end
  end

  private

  def period_for_scraping_finished?
    time_from_last_match >= period_of_scraping_after_finished
  end

  def period_of_scraping_after_finished
    (days_of_scraping_after_finished * 1.day.seconds).to_i
  end

  def time_from_last_match
    diff_date(Time.current, last_dated_match.date)
  end

  def last_dated_match
    championship.last_dated_match
  end

  def diff_date(date1, date2)
    (date1 - date2).to_i
  end
end

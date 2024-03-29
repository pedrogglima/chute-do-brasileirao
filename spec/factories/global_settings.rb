# frozen_string_literal: true

FactoryBot.define do
  factory :global_setting do
    association :championship
    singleton_guard { 0 }
    days_of_scraping_after_finished { 3 }

    initialize_with do
      GlobalSetting.where(singleton_guard: 0).first_or_create
    end
  end
end

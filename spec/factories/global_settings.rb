# frozen_string_literal: true

FactoryBot.define do
  factory :global_setting do
    singleton_guard { 0 }
    association :championship

    initialize_with do
      GlobalSetting.where(singleton_guard: 0).first_or_create
    end
  end
end

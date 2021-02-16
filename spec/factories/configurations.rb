# frozen_string_literal: true
require 'securerandom'

FactoryBot.define do
  factory :configuration do
    singleton_guard { 0 }
    association :championship

    initialize_with do
      Configuration.where(singleton_guard: 0).first_or_create
    end
  end
end

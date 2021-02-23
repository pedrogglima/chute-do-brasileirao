# frozen_string_literal: true

FactoryBot.define do
  factory :league do
    association :division
    name { Faker::Sports::Football.competition }
  end
end

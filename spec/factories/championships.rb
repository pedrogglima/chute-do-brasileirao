# frozen_string_literal: true

FactoryBot.define do
  factory :championship do
    association :league
    year { 2021 }
    number_of_participants { 20 }
  end
end

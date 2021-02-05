# frozen_string_literal: true
require 'securerandom'

FactoryBot.define do
  factory :championship do
    association :league
    year { Faker::Date.between(from: '2000-01-01', to: '2020-01-01') }
    number_of_participants { 20 }
  end
end

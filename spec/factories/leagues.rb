# frozen_string_literal: true
require 'securerandom'

FactoryBot.define do
  factory :league do
    association :division
    name { Faker::Sports::Football.competition }
  end
end

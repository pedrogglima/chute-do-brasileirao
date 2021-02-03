# frozen_string_literal: true
require 'securerandom'

FactoryBot.define do
  factory :team do
    name { Faker::Sports::Football.team }
    state { Faker::Address.country_code }
  end
end

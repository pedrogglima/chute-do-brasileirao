# frozen_string_literal: true
require 'securerandom'

FactoryBot.define do
  factory :league do
    name { Faker::Sports::Football.competition }
    division { Faker::Esport.league }
  end
end

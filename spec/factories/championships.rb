# frozen_string_literal: true
require 'securerandom'

FactoryBot.define do
  factory :championship do
    association :league
    year { 2021 }
    number_of_participants { 20 }
  end
end

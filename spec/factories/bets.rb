# frozen_string_literal: true
require 'securerandom'

FactoryBot.define do
  factory :bet do
    association :user
    association :match
    score_team { 1 }
    score_opponent { 1 }
  end
end

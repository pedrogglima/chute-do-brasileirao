# frozen_string_literal: true
require 'securerandom'

FactoryBot.define do
  factory :bet do
    association :user
    association :match
    bet_team_score { 1 }
    bet_opponent_score { 1 }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :bet do
    association :user
    association :match, factory: [:match, :not_played_yet]
    bet_team_score { 1 }
    bet_opponent_score { 1 }
  end
end

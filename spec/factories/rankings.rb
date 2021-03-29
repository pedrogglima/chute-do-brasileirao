# frozen_string_literal: true

FactoryBot.define do
  factory :ranking do
    association :championship
    association :team
    association :next_opponent, factory: :team

    position { 10 }
    points { 10 }
    played { 10 }
    won { 10 }
    drawn { 10 }
    lost { 10 }
    goals_for { 10 }
    goals_against { 10 }
    goal_difference { 10 }
    yellow_card { 10 }
    red_card { 10 }
    advantages { 10 }
    form { 'VVV' }
  end
end

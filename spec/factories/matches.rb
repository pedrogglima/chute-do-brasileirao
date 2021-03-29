# frozen_string_literal: true

FactoryBot.define do
  trait :already_played do
    date { 1.minute.ago }
  end

  trait :is_not_today do
    date { 1.day.ago }
  end

  trait :is_today do
    date { 1.minute.from_now }
  end

  trait :not_played_yet do
    date { 1.minute.from_now }
  end

  factory :match do
    association :championship
    association :round
    association :team
    association :opponent, factory: :team
    id_match { rand(1..380) }
    date do
      Faker::Time.between(
        from: Time.now - 360,
        to: Time.now,
        format: :default
      )
    end
    updates { 'Alterações: 1' }
    team_score { 1 }
    opponent_score { 1 }
    place { 'Estadio - Cidadade - Estado' }
    start_at { '18h00' }
  end
end

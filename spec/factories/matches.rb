# frozen_string_literal: true
require 'securerandom'

FactoryBot.define do
  factory :match do
    association :championship
    association :round
    association :team
    association :opponent, factory: :team
    id_match { 100 }
    date do
      Faker::Time.between(
        from: Time.now - 360,
        to: Time.now,
        format: :default
      )
    end
    number_of_changes { "Alterações: 1" }
    team_score { 1 }
    opponent_score { 1 }
    place { "Estadio - Cidadade - Estado" }
  end
end

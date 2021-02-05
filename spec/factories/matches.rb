# frozen_string_literal: true
require 'securerandom'

FactoryBot.define do
  factory :match do
    association :table
    association :team, name: "team"
    association :opponent, factory: :team, name: "opponent"
    identification { "Jogo: 100" }
    date do
      Faker::Time.between(
        from: Time.now - 360,
        to: Time.now,
        format: :default
      )
    end
    number_of_changes { "Alterações: 1" }
    score { "1 x 1" }
    place { "Estadio - Cidadade - Estado" }
  end
end

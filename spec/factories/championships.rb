# frozen_string_literal: true

FactoryBot.define do
  factory :championship do
    association :league
    year { 2021 }
    number_of_participants { 20 }
    number_of_matches { 380 }

    factory :championship_full_dated do
      after(:create) do |championship, _evaluator|
        # replace a query to count 380 matches instances
        allow(championship).to receive(:count_dated_matches).and_return 380
      end
    end
  end
end

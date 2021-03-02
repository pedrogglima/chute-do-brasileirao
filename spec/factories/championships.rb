# frozen_string_literal: true

FactoryBot.define do
  factory :championship do
    association :league
    year { 2021 }
    number_of_participants { 20 }

    factory :championship_not_finished do
      after(:create) do |championship, _evaluator|
        # replace a query to count 380 matches instances
        allow(championship).to receive(:count_dated_matches).and_return 380

        # last dated match
        create(:match, championship: championship, date: 1.day.ago)
      end
    end

    factory :championship_finished do
      after(:create) do |championship, _evaluator|
        # replace a query to count 380 matches instances
        allow(championship).to receive(:count_dated_matches).and_return 380

        # last dated match
        create(:match, championship: championship, date: 3.days.ago)
      end
    end
  end
end

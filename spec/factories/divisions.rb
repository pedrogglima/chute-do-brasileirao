# frozen_string_literal: true

FactoryBot.define do
  factory :division do
    name { Faker::Name.unique.name }
  end
end

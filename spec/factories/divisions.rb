# frozen_string_literal: true
require 'securerandom'

FactoryBot.define do
  factory :division do
    name { Faker::Name.unique.name }
  end
end

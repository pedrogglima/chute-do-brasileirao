# frozen_string_literal: true
require 'securerandom'

FactoryBot.define do
  factory :round do
    association :championship
  end
end

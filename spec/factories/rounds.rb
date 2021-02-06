# frozen_string_literal: true
require 'securerandom'

FactoryBot.define do
  factory :round do
    association :championship
    number { 1 }
  end
end

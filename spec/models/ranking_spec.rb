# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Ranking, type: :model) do
  let!(:ranking) { create :ranking }

  describe 'associations' do
    it { should belong_to(:championship) }
    it { should belong_to(:team) }
    it { should belong_to(:next_opponent).optional(true) }
  end

  describe 'validations' do
    it { should validate_presence_of(:position) }
    it { should validate_numericality_of(:position) }
    it { should validate_inclusion_of(:position).in_range(1..20) }
    it { should validate_presence_of(:points) }
    it { should validate_presence_of(:played) }
    it { should validate_presence_of(:won) }
    it { should validate_presence_of(:drawn) }
    it { should validate_presence_of(:lost) }
    it { should validate_presence_of(:goals_for) }
    it { should validate_presence_of(:goals_against) }
    it { should validate_presence_of(:goal_difference) }
    it { should validate_presence_of(:yellow_card) }
    it { should validate_presence_of(:red_card) }
    it { should validate_presence_of(:advantages) }
  end

  describe 'attributes' do
    context 'with valid params' do
      it { expect(ranking).to(be_valid) }
    end
  end
end

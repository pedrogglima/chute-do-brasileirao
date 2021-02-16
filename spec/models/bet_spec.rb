# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(Bet, type: :model) do
  subject(:bet) { create(:bet) }

  describe 'associations' do
    context 'belongs_to' do
      it { should belong_to(:user) }
      it { should belong_to(:match) }
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:bet_team_score) }
    it { should validate_numericality_of(:bet_team_score) }
    it { should validate_inclusion_of(:bet_team_score).in_range(0..100) }
    it { should validate_presence_of(:bet_opponent_score) }
    it { should validate_numericality_of(:bet_opponent_score) }
    it { should validate_inclusion_of(:bet_opponent_score).in_range(0..100) }
  end

  describe 'attributes' do
    context 'with valid params' do
      it { expect(bet).to(be_valid) }
    end
  end

  describe 'creation_period' do
    let(:match_already_played) { create(:match, :already_played) }
    let(:match_is_not_today) { create(:match, :is_not_today) }
    let(:match_not_played_yet) { create(:match, :not_played_yet) }

    context 'when match already played' do
      let(:bet) { build(:bet, match: match_already_played) }

      it { expect(bet).to_not(be_valid) }
    end

    context 'when match is not today' do
      let(:bet) { build(:bet, match: match_is_not_today) }

      it { expect(bet).to_not(be_valid) }
    end

    context 'when match is today and is not played yet' do
      let(:bet) { build(:bet, match: match_not_played_yet) }

      it { expect(bet).to(be_valid) }
    end
  end
end

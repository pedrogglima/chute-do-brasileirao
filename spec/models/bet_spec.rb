# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(Bet, type: :model) do
  let!(:bet) { create :bet }

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

  describe 'bet_team_score' do
    subject { bet }

    context 'when empty' do
      before do
        bet.bet_team_score = nil
      end

      it { is_expected.to_not(be_valid) }
    end
  end

  describe 'bet_opponent_score' do
    subject { bet }

    context 'when empty' do
      before do
        bet.bet_opponent_score = nil
      end

      it { is_expected.to_not(be_valid) }
    end

    context 'when out of range' do
      before { bet.bet_opponent_score = 101 }

      it { is_expected.to_not(be_valid) }
    end
  end
end

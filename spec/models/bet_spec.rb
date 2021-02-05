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
    it { should validate_presence_of(:score_team) }
    it { should validate_numericality_of(:score_team) }
    it { should validate_inclusion_of(:score_team).in_range(0..100) }
    it { should validate_presence_of(:score_opponent) }
    it { should validate_numericality_of(:score_team) }
    it { should validate_inclusion_of(:score_opponent).in_range(0..100) }
  end

  describe 'attributes' do
    context 'with valid params' do
      it { expect(bet).to(be_valid) }
    end
  end

  describe 'score_team' do
    subject { bet }

    context 'when empty' do
      before do
        bet.score_team = nil
      end

      it { is_expected.to_not(be_valid) }
    end
  end

  describe 'score_opponent' do
    subject { bet }

    context 'when empty' do
      before do
        bet.score_opponent = nil
      end

      it { is_expected.to_not(be_valid) }
    end

    context 'when out of range' do
      before { bet.score_opponent = 101 }

      it { is_expected.to_not(be_valid) }
    end
  end
end

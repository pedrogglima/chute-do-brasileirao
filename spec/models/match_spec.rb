# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Match, type: :model) do
  subject(:match) { create(:match) }

  describe 'associations' do
    it { should belong_to(:championship) }
    it { should belong_to(:round) }
    it { should belong_to(:team) }
    it { should belong_to(:opponent) }
  end

  describe 'validations' do
    it { should validate_presence_of(:id_match) }
    it { should validate_uniqueness_of(:id_match).scoped_to(:championship_id) }
    it { should validate_numericality_of(:id_match) }
    it { should validate_inclusion_of(:id_match).in_range(1..380) }

    it { should allow_value(:nil).for(:team_score) }
    it { should validate_numericality_of(:team_score) }
    it { should validate_inclusion_of(:team_score).in_range(0..100) }

    it { should allow_value(:nil).for(:opponent_score) }
    it { should validate_numericality_of(:opponent_score) }
    it { should validate_inclusion_of(:opponent_score).in_range(0..100) }
  end

  describe 'attributes' do
    context 'with valid params' do
      it { expect(match).to(be_valid) }
    end
  end

  describe 'today?' do
    context 'when match date is nil' do
      let(:match) { build_stubbed(:match, date: nil) }

      it { expect(match.today?).to(be(false)) }
    end

    context 'when match is not today' do
      let(:match) { build_stubbed(:match, :is_not_today) }

      it { expect(match.today?).to(be(false)) }
    end

    context 'when match is today' do
      let(:match) { build_stubbed(:match, :is_today) }

      it { expect(match.today?).to(be(true)) }
    end
  end

  describe 'already_played?' do
    context 'when match date is nil' do
      let(:match) { build_stubbed(:match, date: nil) }

      it { expect(match.already_played?).to(be(false)) }
    end

    context 'when match is already played' do
      let(:match) { build_stubbed(:match, :already_played) }

      it { expect(match.already_played?).to(be(true)) }
    end

    context 'when match is not played yet' do
      let(:match) { build_stubbed(:match, :not_played_yet) }
      it { expect(match.already_played?).to(be(false)) }
    end
  end
end

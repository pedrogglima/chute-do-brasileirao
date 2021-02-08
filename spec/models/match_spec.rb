# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(Match, type: :model) do
  let!(:match) { create :match }

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
  end

  describe 'attributes' do
    context 'with valid params' do
      it { expect(match).to(be_valid) }
    end
  end

  describe 'id_match' do
    subject { match }

    context 'when empty' do
      before do
        match.id_match = nil
      end

      it { is_expected.to_not(be_valid) }
    end
  end
end

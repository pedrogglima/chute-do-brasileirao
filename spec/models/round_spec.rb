# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(Round, type: :model) do
  let!(:round) { create :round }

  describe 'associations' do
    it { should belong_to(:championship) }
    it { should have_many(:matches) }
  end

  describe 'validations' do
    it { should validate_presence_of(:number) }
    it { should validate_uniqueness_of(:number).scoped_to(:championship_id) }
    it { should validate_numericality_of(:number) }
    it { should validate_inclusion_of(:number).in_range(1..38) }
  end

  describe 'attributes' do
    context 'with valid params' do
      it { expect(round).to(be_valid) }
    end
  end

  describe 'number' do
    subject { round }

    context 'when empty' do
      before do
        round.number = nil
      end

      it { is_expected.to_not(be_valid) }
    end
  end
end

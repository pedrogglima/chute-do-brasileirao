# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(Championship, type: :model) do
  let!(:championship) { create :championship }

  describe 'associations' do
    context 'have_many' do
      it { should have_many(:matches) }
      it { should have_many(:rankings) }
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:year) }
    it { should validate_uniqueness_of(:year).scoped_to(:league_id) }
    it { should validate_numericality_of(:year) }
    it { should validate_inclusion_of(:year).in_range(2020..3000) }
    it { should validate_presence_of(:number_of_participants) }
    it { should validate_numericality_of(:number_of_participants) }
    it { should validate_inclusion_of(:number_of_participants).in_range(1..1000) }
  end

  describe 'attributes' do
    context 'with valid params' do
      it { expect(championship).to(be_valid) }
    end
  end

  describe 'year' do
    subject { championship }

    context 'when empty' do
      before do
        championship.year = nil
      end

      it { is_expected.to_not(be_valid) }
    end
  end

  describe 'number_of_participants' do
    subject { championship }

    context 'when empty' do
      before do
        championship.number_of_participants = nil
      end

      it { is_expected.to_not(be_valid) }
    end
  end
end

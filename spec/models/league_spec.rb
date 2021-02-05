# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(League, type: :model) do
  let!(:league) { create :league }

  describe 'associations' do
    context 'have_many' do
      it { should have_many(:championships) }
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:division) }
  end

  describe 'attributes' do
    context 'with valid params' do
      it { expect(league).to(be_valid) }
    end
  end

  describe 'name' do
    subject { league }

    context 'when empty' do
      before do
        league.name = nil
      end

      it { is_expected.to_not(be_valid) }
    end

    context 'when too long' do
      before { league.name = 'Name' * 100 }

      it { is_expected.to_not(be_valid) }
    end
  end

  describe 'division' do
    subject { league }

    context 'when empty' do
      before do
        league.division = nil
      end

      it { is_expected.to(be_valid) }
    end

    context 'when too long' do
      before { league.division = 'SP' * 100 }

      it { is_expected.to_not(be_valid) }
    end
  end
end

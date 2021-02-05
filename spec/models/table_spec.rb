# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(Table, type: :model) do
  let!(:table) { create :table }

  describe 'validations' do
    it { should validate_presence_of(:year) }
    it { should validate_uniqueness_of(:year).scoped_to(:league_id) }
    it { should validate_presence_of(:number_of_participants) }
  end

  describe 'attributes' do
    context 'with valid params' do
      it { expect(table).to(be_valid) }
    end
  end

  describe 'year' do
    subject { table }

    context 'when empty' do
      before do
        table.year = nil
      end

      it { is_expected.to_not(be_valid) }
    end
  end

  describe 'number_of_participants' do
    subject { table }

    context 'when empty' do
      before do
        table.number_of_participants = nil
      end

      it { is_expected.to_not(be_valid) }
    end

    context 'when out of range' do
      before { table.number_of_participants = 1001 }

      it { is_expected.to_not(be_valid) }
    end
  end
end

# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(Team, type: :model) do
  let!(:team) { create :team }

  describe 'associations' do
    it { should have_many(:matches) }
    it { should have_many(:opponents) }
    it { should have_many(:next_opponents) }
    it { should have_many(:rankings) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:state) }
    it { should validate_uniqueness_of(:name) }
  end

  describe 'attributes' do
    context 'with valid params' do
      it { expect(team).to(be_valid) }
    end
  end

  describe 'name' do
    subject { team }

    context 'when empty' do
      before do
        team.name = nil
      end

      it { is_expected.to_not(be_valid) }
    end

    context 'when too long' do
      before { team.name = 'Name' * 100 }

      it { is_expected.to_not(be_valid) }
    end
  end

  describe 'state' do
    subject { team }

    context 'when empty' do
      before do
        team.state = nil
      end

      it { is_expected.to_not(be_valid) }
    end

    context 'when too long' do
      before { team.state = 'SP' * 2 }

      it { is_expected.to_not(be_valid) }
    end
  end
end

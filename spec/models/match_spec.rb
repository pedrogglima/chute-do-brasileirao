# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(Match, type: :model) do
  let!(:match) { create :match }

  describe 'associations' do
    context 'belongs_to' do
      it { should belong_to(:championship) }
      it { should belong_to(:team) }
      it { should belong_to(:opponent) }
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:identification) }
  end

  describe 'attributes' do
    context 'with valid params' do
      it { expect(match).to(be_valid) }
    end
  end

  describe 'identification' do
    subject { match }

    context 'when empty' do
      before do
        match.identification = nil
      end

      it { is_expected.to_not(be_valid) }
    end
  end
end

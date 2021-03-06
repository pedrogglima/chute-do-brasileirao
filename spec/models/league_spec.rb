# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(League, type: :model) do
  let!(:league) { create :league }

  describe 'associations' do
    it { should have_many(:championships) }
    it { should belong_to(:division) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(1).is_at_most(100) }
    it { should validate_uniqueness_of(:name).scoped_to(:division_id) }
  end

  describe 'attributes' do
    context 'with valid params' do
      it { expect(league).to(be_valid) }
    end
  end
end

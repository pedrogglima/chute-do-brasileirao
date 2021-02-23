# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Division, type: :model) do
  let!(:division) { create :division }

  describe 'associations' do
    it { should have_many(:leagues) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(1).is_at_most(100) }
    it { should validate_uniqueness_of(:name) }
  end

  describe 'attributes' do
    context 'with valid params' do
      it { expect(division).to(be_valid) }
    end
  end
end

# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(Round, type: :model) do
  let(:round) { create :round }

  describe 'associations' do
    it { should belong_to(:championship) }
    it { should have_many(:matches) }
  end

  describe 'attributes' do
    context 'with valid params' do
      it { expect(round).to(be_valid) }
    end
  end
end

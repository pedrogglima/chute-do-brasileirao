# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(GlobalSetting, type: :model) do
  let!(:setting) { create :global_setting }

  describe 'associations' do
    it { should belong_to(:championship) }
  end

  describe 'validations' do
    it { should validate_presence_of(:singleton_guard) }
    it { should validate_uniqueness_of(:singleton_guard) }
    it { should validate_numericality_of(:singleton_guard) }
    it { should validate_inclusion_of(:singleton_guard).in_array([0]) }
  end
end

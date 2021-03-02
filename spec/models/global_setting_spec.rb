# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(GlobalSetting, type: :model) do
  let!(:championship) { create :championship }
  let!(:setting) { create :global_setting, championship: championship }

  describe 'associations' do
    it { should belong_to(:championship) }
  end

  describe 'validations' do
    it { should validate_presence_of(:singleton_guard) }
    it { should validate_uniqueness_of(:singleton_guard) }
    it { should validate_numericality_of(:singleton_guard) }
    it { should validate_inclusion_of(:singleton_guard).in_array([0]) }

    it { should validate_presence_of(:cbf_url) }

    it { should validate_presence_of(:granted_period) }
    it { should validate_numericality_of(:granted_period) }
  end

  describe 'url_current_championship' do
    before do
      setting.cbf_url =
        'https://www.cbf.com.br/futebol-brasileiro/competicoes/campeonato-brasileiro-serie-a'

      championship.year = 2020
    end

    it do
      expect(
        setting.url_current_championship
      ).to(
        eq(
          'https://www.cbf.com.br/futebol-brasileiro/competicoes/campeonato-brasileiro-serie-a/2020'
        )
      )
    end
  end

  describe 'granted_period_in_seconds' do
    before { setting.granted_period = 3 }

    it do expect(setting.granted_period_in_seconds).to(eq(3.days.seconds)) end
  end
end

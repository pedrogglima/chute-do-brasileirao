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

    it { should validate_presence_of(:days_of_scraping_after_finished) }
    it { should validate_numericality_of(:days_of_scraping_after_finished) }
    it do
      should validate_inclusion_of(:days_of_scraping_after_finished)
        .in_range(1..100)
    end
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

  describe 'continuing_scraping_current_championship?' do
    let(:championship_full_dated) { create(:championship_full_dated) }
    let(:setting) do
      create(
        :global_setting,
        championship: championship_full_dated,
        days_of_scraping_after_finished: 3
      )
    end

    context 'when championship not finished' do
      before do
        create(
          :match,
          championship: championship_full_dated,
          date: 1.minute.from_now
        )
      end

      it { expect(setting.continuing_scraping?).to(be(true)) }
    end

    context 'when championship finished' do
      context 'but last dated match isn\'t greater than \
      period of scraping after finished' do
        before do
          create(
            :match,
            championship: championship_full_dated,
            date: 1.minute.ago
          )
        end

        it { expect(setting.continuing_scraping?).to(be(true)) }
      end

      context 'but last dated match is equal or greater than \
      period of scraping after finished' do
        before do
          create(
            :match,
            championship: championship_full_dated,
            date: 3.days.ago
          )
        end

        it { expect(setting.continuing_scraping?).to(be(false)) }
      end
    end
  end
end

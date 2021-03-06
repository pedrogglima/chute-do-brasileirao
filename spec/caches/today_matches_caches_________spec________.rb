# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Cache::TodayMatchesService, type: :service) do
  let(:global_setting) { create(:global_setting) }
  let(:championship) { global_setting.championship }
  let(:cache_resources_service) do
    Cache::TodayMatchesService.new({ current_championship_id: championship.id })
  end

  let(:key) { Cache::TodayMatchesService::KEY }
  let(:exp) { Cache::TodayMatchesService::EXP }
  let(:from) { Cache::TodayMatchesService::FROM }
  let(:to) { Cache::TodayMatchesService::TO }

  let(:create_resources) do
    # p.s create_list syntax didn't set the championship assoc.
    5.times do |i|
      create(:match, :is_today, id_match: (i + 1), championship: championship)
    end
  end

  mock_redis_setup do
    describe '#call' do
      subject { cache_resources_service.call }

      context 'should have constants' do
        it { expect(key).to eq('today_matches_list') }
        it { expect(exp).to eq(3600) }
        it { expect(from).to eq(0) }
        it { expect(to).to eq(-1) }
      end

      it 'should return' do
        is_expected.to be_a(Array)
      end

      context 'when resources do not exist' do
        it 'should return' do
          cache_resources = cache_resources_service.call
          expect(cache_resources.length).to eq(0)
        end
      end

      context 'when resources do exist' do
        it 'should return all list' do
          create_resources
          cache_resources = cache_resources_service.call
          expect(cache_resources.length).to eq(5)
        end
      end
    end
  end
end
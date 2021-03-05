# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Cache::TopRankingsService, type: :service) do
  let(:global_setting) { create(:global_setting) }
  let(:championship) { global_setting.championship }
  let(:cache_resources_service) do
    Cache::TopRankingsService.new(
      { current_championship_id: championship.id }
    )
  end

  let(:key) { Cache::TopRankingsService::KEY }
  let(:exp) { Cache::TopRankingsService::EXP }
  let(:from) { Cache::TopRankingsService::FROM }
  let(:to) { Cache::TopRankingsService::TO }

  let(:create_resources) do
    # p.s create_list syntax didn't set the championship assoc.
    20.times do |i|
      create(:ranking, posicao: (i + 1), championship: championship)
    end
  end

  mock_redis_setup do
    describe '#call' do
      subject { cache_resources_service.call }

      context 'should have constants' do
        it { expect(key).to eq('ranking_list') }
        it { expect(exp).to eq(3600) }
        it { expect(from).to eq(0) }
        it { expect(to).to eq(5) }
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
        it 'should return 6 resources' do
          create_resources
          cache_resources = cache_resources_service.call
          expect(cache_resources.length).to eq(6)
        end
      end
    end
  end
end

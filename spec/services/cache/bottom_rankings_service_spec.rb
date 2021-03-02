# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Cache::BottomRankingsService, type: :service) do
  let(:global_setting) { create(:global_setting) }
  let(:championship) { global_setting.championship }
  let(:cache_resources_service) do
    Cache::BottomRankingsService.new(
      { current_championship_id: championship.id }
    )
  end

  let(:key) { Cache::BottomRankingsService::KEY }
  let(:exp) { Cache::BottomRankingsService::EXP }
  let(:from) { Cache::BottomRankingsService::FROM }
  let(:to) { Cache::BottomRankingsService::TO }

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
        it { expect(from).to eq(16) }
        it { expect(to).to eq(19) }
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
        it 'should return 4 resources' do
          create_resources
          cache_resources = cache_resources_service.call
          expect(cache_resources.length).to eq(4)
        end
      end
    end
  end
end

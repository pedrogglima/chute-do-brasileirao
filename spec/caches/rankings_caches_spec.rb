# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(RankingsCaches, type: :cache) do
  let(:global_setting) { create(:global_setting) }
  let(:current_championship) { global_setting.championship }

  let(:key) { RankingsCaches::KEY }

  let(:create_ranking) do
    create(:ranking, championship: current_championship)
  end

  let(:query_rankings) do
    Ranking.all
           .team_with_avatar
           .next_opponent_with_avatar
           .where(championship_id: current_championship.id)
           .order(position: :asc)
  end

  mock_redis_setup do
    describe 'constants' do
      it { expect(key).to eq('rankings_list') }
    end

    describe 'set/get' do
      let(:create_rankings) do
        20.times do |i|
          create(:ranking, position: (i + 1), championship: current_championship)
        end
      end

      before do
        create_rankings
        subject.set(
          query_rankings,
          'rankings/partials/ranking',
          'ranking'
        )
      end

      context 'when passed argument' do
        it { expect(subject.get(0, 5).length).to eq(6) }
      end

      it { expect(subject.get).to be_an(Array) }
      it { expect(subject.get.length).to eq(20) }
      it { expect(subject.get[0]).to be_an(String) }
    end
  end
end

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
           .order(posicao: :asc)
  end

  mock_redis_setup do
    describe 'constants' do
      it { expect(key).to eq('rankings_list') }
    end

    describe 'initialize' do
      subject { RankingsCaches.new }

      context 'whithout argument' do
        it { expect(subject.from).to eq(0) }
        it { expect(subject.to).to eq(-1) }
      end
    end

    describe 'cache' do
      subject { RankingsCaches.new }

      context 'when cache is not' do
        before do
          create_ranking
          subject.set(query_rankings)
        end

        it { expect(subject.cached?).to eq(true) }
      end

      context 'when cache is empty' do
        it { expect(subject.cached?).to eq(false) }
      end
    end

    describe 'set' do
      # TODO, compare with private method to_json
    end

    describe 'get' do
      let(:create_rankings) do
        20.times do |i|
          create(:ranking, posicao: (i + 1), championship: current_championship)
        end
      end

      before do
        create_rankings
        subject.set(query_rankings)
      end

      context 'when passed argument' do
        it { expect(subject.get(0, 5).length).to eq(6) }
      end

      it { expect(subject.get).to be_an(Array) }
      it { expect(subject.get.length).to eq(20) }
      it { expect(subject.get[0]).to be_an(Hash) }
      it { expect(subject.get[0][:id]).to be_an(Integer) }
    end
  end
end

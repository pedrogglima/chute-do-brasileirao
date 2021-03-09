# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(TodayMatchesCaches, type: :cache) do
  let(:global_setting) { create(:global_setting) }
  let(:current_championship) { global_setting.championship }

  let(:key) { TodayMatchesCaches::KEY }

  let(:create_today_matches) do
    create(:match, date: Time.current, championship: current_championship)
  end

  let(:query_today_matches) do
    Match.team_with_avatar
         .opponent_with_avatar
         .today_matches
         .where(championship_id: current_championship.id)
         .order(date: :asc)
  end

  mock_redis_setup do
    describe 'constants' do
      it { expect(key).to eq('today_matches_list') }
    end

    describe 'initialize' do
      subject { TodayMatchesCaches.new }

      context 'whithout argument' do
        it { expect(subject.from).to eq(0) }
        it { expect(subject.to).to eq(-1) }
      end
    end

    describe 'cache' do
      subject { TodayMatchesCaches.new }

      context 'when cache is not' do
        before do
          create_today_matches
          subject.set(query_today_matches)
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
      let(:create_3_today_matches) do
        3.times do
          create(:match, date: Time.current, championship: current_championship)
        end
      end

      before do
        create_3_today_matches
        subject.set(query_today_matches)
      end
      it { expect(subject.get).to be_an(Array) }
      it { expect(subject.get.length).to eq(3) }
      it { expect(subject.get[0]).to be_an(Hash) }
      it { expect(subject.get[0][:id]).to be_an(Integer) }
    end
  end
end

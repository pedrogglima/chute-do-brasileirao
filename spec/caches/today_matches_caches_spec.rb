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

    describe 'set/get' do
      let(:create_3_today_matches) do
        3.times do
          create(:match, date: Time.current, championship: current_championship)
        end
      end

      before do
        create_3_today_matches
        subject.set(
          query_today_matches,
          'index/partials/today_match',
          'match'
        )
      end
      it { expect(subject.get).to be_an(Array) }
      it { expect(subject.get.length).to eq(3) }
      it { expect(subject.get[0]).to be_an(String) }
    end
  end
end

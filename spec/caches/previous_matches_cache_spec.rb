# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(PreviousMatchesCache, type: :cache) do
  let(:global_setting) { create(:global_setting) }
  let(:current_championship) { global_setting.championship }

  subject { PreviousMatchesCache }

  mock_redis_setup do
    describe 'constants' do
      let(:key) { PreviousMatchesCache::KEY }
      let(:key_page) { PreviousMatchesCache::KEY_PAGY }

      it { expect(key).to eq('previous_matches_list') }
      it { expect(key_page).to eq('previous_matches_list_pagy') }
    end

    describe 'set/get' do
      let(:retrived_pagy) do
        {
          'count' => 150,
          'items' => 15,
          'last' => 10,
          'page' => 1,
          'pages' => 10
        }
      end

      let(:create_match) do
        create(:match, date: 2.days.ago, championship: current_championship)
      end

      let(:create_pagy) do
        double(
          page: 1,
          pages: 10,
          last: 10,
          items: 15,
          count: 150
        )
      end

      let(:query_previous_matches) do
        Match.team_with_avatar
             .opponent_with_avatar
             .previous_matches(Date.yesterday.end_of_day)
             .where(championship_id: current_championship.id)
             .order(date: :asc)
      end

      before do
        create_match
        subject.set(
          query_previous_matches,
          create_pagy,
          'index/partials/previous_match',
          'match'
        )
      end

      it { expect(subject.get).to be_an(Array) }
      it { expect(subject.get.length).to eq(2) }
      it 'expect first instance from return be pagy' do
        pagy, resources = subject.get
        expect(pagy).to eq(retrived_pagy)
      end

      it 'expect second instance from return to be array' do
        pagy, resources = subject.get
        expect(resources).to be_an(Array)
      end

      it 'expect second instance from return to be array of resouces' do
        pagy, resources = subject.get
        expect(resources[0]).to be_an(String)
      end
    end
  end
end

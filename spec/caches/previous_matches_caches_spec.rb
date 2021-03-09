# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(PreviousMatchesCaches, type: :cache) do
  let(:global_setting) { create(:global_setting) }
  let(:current_championship) { global_setting.championship }

  let(:key) { PreviousMatchesCaches::KEY }
  let(:key_page) { PreviousMatchesCaches::KEY_PAGY }

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

  mock_redis_setup do
    describe 'constants' do
      it { expect(key).to eq('previous_matches_list') }
      it { expect(key_page).to eq('previous_matches_list_pagy') }
    end

    describe 'initialize' do
      subject { PreviousMatchesCaches.new }

      context 'whithout argument' do
        it { expect(subject.from).to eq(0) }
        it { expect(subject.to).to eq(-1) }
      end
    end

    describe 'cache' do
      subject { PreviousMatchesCaches.new }

      context 'when cache is not' do
        # TODO
      end

      context 'when cache is empty' do
        it { expect(subject.cached?).to eq(false) }
      end
    end

    describe 'set' do
      # TODO
    end

    describe 'get' do
      # TODO
    end
  end
end

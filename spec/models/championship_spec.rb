# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Championship, type: :model) do
  let!(:championship) { create :championship }

  describe 'associations' do
    context 'have_many' do
      it { should have_many(:matches) }
      it { should have_many(:rankings) }
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:year) }
    it { should validate_uniqueness_of(:year).scoped_to(:league_id) }
    it { should validate_numericality_of(:year) }
    it { should validate_inclusion_of(:year).in_range(2020..3000) }

    it { should validate_presence_of(:number_of_participants) }
    it { should validate_numericality_of(:number_of_participants) }
    it do
      should validate_inclusion_of(:number_of_participants).in_range(1..1000)
    end

    it { should validate_presence_of(:number_of_matches) }
    it { should validate_numericality_of(:number_of_matches) }
  end

  describe 'attributes' do
    context 'with valid params' do
      it { expect(championship).to(be_valid) }
    end
  end

  describe 'finished?' do
    context 'when count_dated_match is less than number_of_matches' do
      before { create(:match, championship: championship, date: Time.now) }

      it { expect(championship.finished?).to(be(false)) }
    end

    context 'when all matches are already dated' do
      let(:championship_full_dated) { create(:championship_full_dated) }

      context 'but last dated match isn\'t greater than current time' do
        it do
          create(
            :match,
            championship: championship_full_dated,
            date: 1.minute.from_now
          )

          expect(championship_full_dated.finished?).to(be(false))
        end
      end

      context 'but last dated match is greater than current time' do
        it do
          create(
            :match,
            championship: championship_full_dated,
            date: 1.minute.ago
          )

          expect(championship_full_dated.finished?).to(be(true))
        end
      end
    end
  end
end

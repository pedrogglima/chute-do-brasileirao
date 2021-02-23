# frozen_string_literal: true

require 'rails_helper'

describe BetPolicy do
  subject { described_class.new(user, bet) }

  let(:user) { create(:user) }
  let(:bet) { create(:bet, user: user) }

  context 'not owner' do
    let(:bet) { create(:bet) }

    it { is_expected.to_not(permit_action(:show)) }
  end

  context 'owner' do
    it { is_expected.to(permit_action(:show)) }
  end
end

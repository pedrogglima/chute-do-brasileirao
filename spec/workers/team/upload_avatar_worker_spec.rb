# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Team::UploadAvatarWorker, type: :worker) do
  let(:team) { create(:team) }

  describe 'settings' do
    it { is_expected.to(be_retryable(true)) }
    it { is_expected.to(be_processed_in(:default)) }
  end

  it 'should increase workers' do
    expect do
      team
    end.to(change(Team::UploadAvatarWorker.jobs, :size).by(1))
  end

  # This test guarantes that a raised exception will be catch here
  it 'should perform task' do
    Team::UploadAvatarWorker.new.perform(team.id)
    expect(team.reload.avatar.attached?).to(be(true))
  end
end

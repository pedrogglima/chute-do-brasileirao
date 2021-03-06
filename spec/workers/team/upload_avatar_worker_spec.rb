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
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(ScrapCbfWorker, type: :worker) do
  let!(:setting) { create(:global_setting) }

  describe 'settings' do
    it { is_expected.to(be_retryable(true)) }
    it { is_expected.to(be_processed_in(:default)) }
  end

  it 'should increase workers' do
    expect do
      ScrapCbfWorker.perform_at(1.minute.from_now)
    end.to(change(ScrapCbfWorker.jobs, :size).by(1))
  end

  # This test guarantes that a raised exception will be catch here
  it 'should perform task' do
    ScrapCbfWorker.new.perform
  end
end

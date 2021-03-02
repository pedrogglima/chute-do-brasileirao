# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(ScraperWorker, type: :worker) do
  let!(:setting) { create(:global_setting) }

  describe 'settings' do
    it { is_expected.to(be_retryable(true)) }
    it { is_expected.to(be_processed_in(:default)) }
  end

  it 'should increase workers' do
    expect do
      ScraperWorker.perform_at(1.minute.from_now)
    end.to(change(ScraperWorker.jobs, :size).by(1))
  end

  # This test guarantes that a raised exception will be catch here
  it 'should perform task' do
    ScraperWorker.new.perform
  end
end

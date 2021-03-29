# frozen_string_literal: true

class ScrapCbfWorker < ApplicationWorker
  sidekiq_options queue: 'default'

  def perform
    return unless GlobalSetting.singleton.continuing_scraping?

    # TODO: create logic
  end
end

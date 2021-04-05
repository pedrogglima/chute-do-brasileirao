# frozen_string_literal: true

class ScrapCbfWorker < ApplicationWorker
  sidekiq_options queue: 'default'

  def perform
    gs = GlobalSetting.singleton

    return unless gs.continuing_scraping?

    current_championship = gs.championship

    cbf = ScrapCbf.new(year: current_championship.year)

    ScrapCbfRecord::ActiveRecord.save(cbf.to_h)
  end
end

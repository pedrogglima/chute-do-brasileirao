# frozen_string_literal: true

class ScraperWorker < ApplicationWorker
  sidekiq_options queue: 'default'

  def perform
    return unless GlobalSetting.singleton.continuing_scraping?

    url = GlobalSetting.singleton.current_championship_url

    cbf = ScrapPage::CBF.new(url).readable_format

    Parse::CreateTeamsService.call(cbf['teams'])
    Parse::CreateOrUpdateRankingsService.call(cbf['rankings'])
    Parse::CreateOrUpdateRoundsService.call(cbf['rounds'])
  end
end

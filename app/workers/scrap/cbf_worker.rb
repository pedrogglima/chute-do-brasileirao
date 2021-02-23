# frozen_string_literal: true

module Scrap
  # CBF stands for ~ Brazilian soccer championship.
  class CbfWorker
    include Sneakers::Worker
    # env is set to nil otherwise queue name is set to "cbf.all_enviroment_name"
    from_queue 'cbf.all', env: nil

    def work(raw_post)
      cbf = JSON.parse(raw_post)

      Parse::CreateTeamsService.call(cbf['teams'])
      Parse::CreateOrUpdateRankingsService.call(cbf['rankings'])
      Parse::CreateOrUpdateRoundsService.call(cbf['rounds'])

      ack! # acknowledged that message was received
    end
  end
end

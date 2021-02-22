# frozen_string_literal: true

class RankingsController < ApplicationController
  def index
    @rankings = Cache::RankingsService.call(
      { current_championship_id: current_championship.id }
    )
  end
end

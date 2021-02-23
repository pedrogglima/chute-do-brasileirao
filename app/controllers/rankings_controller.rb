# frozen_string_literal: true

class RankingsController < ApplicationController
  def index
    @rankings =
      Cache::RankingsService.call(param_current_championship)
  end

  private

  def param_current_championship
    { current_championship_id: current_championship.id }
  end
end

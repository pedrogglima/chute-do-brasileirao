# frozen_string_literal: true

class IndexController < ApplicationController
  def home
    @today_matches =
      Cache::TodayMatchesService.call(param_current_championship)

    @next_matches =
      Cache::NextMatchesService.call(param_current_championship)

    @previous_matches =
      Cache::PreviousMatchesService.call(param_current_championship)
  end

  def sidebar
    expires_in(1.day, public: true, stale_while_revalidate: 30.seconds)

    @top_rankings =
      Cache::TopRankingsService.call(param_current_championship)

    @bottom_rankings =
      Cache::BottomRankingsService.call(param_current_championship)

    respond_to do |format|
      format.html do
        render partial: 'index/partials/sidebar'
      end
    end
  end

  private

  def param_current_championship
    { current_championship_id: current_championship.id }
  end
end

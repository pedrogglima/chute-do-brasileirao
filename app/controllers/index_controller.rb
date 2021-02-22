# frozen_string_literal: true

class IndexController < ApplicationController
  def home
    @today_matches = Cache::TodayMatchesService.call(
      { current_championship_id: current_championship.id }
    )

    @next_matches = Cache::NextMatchesService.call(
      { current_championship_id: current_championship.id }
    )

    @previous_matches = Cache::PreviousMatchesService.call(
      { current_championship_id: current_championship.id }
    )
  end

  def sidebar
    expires_in(1.day, public: true, stale_while_revalidate: 30.seconds)

    @top_rankings = Cache::TopRankingsService.call(
      { current_championship_id: current_championship.id }
    )

    @bottom_rankings = Cache::BottomRankingsService.call(
      { current_championship_id: current_championship.id }
    )

    respond_to do |format|
      format.html do
        render partial: 'index/partials/sidebar'
      end
    end
  end
end

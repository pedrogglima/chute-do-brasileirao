# frozen_string_literal: true
class IndexController < ApplicationController
  def home
    # TODO: add champship year
    @today_matches = Match.today_matches.order(date: :asc)
    @next_matches = Match.next_matches(Date.tomorrow).order(date: :asc)
    @previous_matches = Match.previous_matches(Date.yesterday)
      .order(date: :desc)
  end

  def sidebar
    # TODO: add champship year
    @top_rankings = Ranking.top_rank.order(posicao: :asc)
    @bottom_rankings = Ranking.bottom_rank.order(posicao: :desc)

    respond_to do |format|
      format.html do
        render partial: 'index/partials/sidebar'
      end
    end
  end
end

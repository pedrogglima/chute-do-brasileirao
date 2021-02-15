# frozen_string_literal: true
class IndexController < ApplicationController
  def home
    # TODO: add champship year
    @today_matches = Match.team_with_avatar
      .opponent_with_avatar
      .today_matches
      .order(date: :asc)

    @next_matches = Match.team_with_avatar
      .opponent_with_avatar
      .next_matches(Date.tomorrow)
      .order(date: :asc)

    @previous_matches = Match.team_with_avatar
      .opponent_with_avatar
      .previous_matches(Date.yesterday)
      .order(date: :desc)
  end

  def sidebar
    # TODO: add champship year
    @top_rankings = Ranking.team_with_avatar
      .top_rank
      .order(posicao: :asc)

    @bottom_rankings = Ranking.team_with_avatar
      .bottom_rank
      .order(posicao: :desc)

    respond_to do |format|
      format.html do
        render partial: 'index/partials/sidebar'
      end
    end
  end
end

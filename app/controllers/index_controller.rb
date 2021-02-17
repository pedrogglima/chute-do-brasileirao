# frozen_string_literal: true
class IndexController < ApplicationController
  before_action :current_championship

  def home
    @today_matches = Match.team_with_avatar
      .opponent_with_avatar
      .today_matches
      .order(date: :asc)

    @next_matches = Match.team_with_avatar
      .opponent_with_avatar
      .next_matches(Date.tomorrow.midnight)
      .where(championship_id: current_championship.id)
      .order(date: :asc)

    @previous_matches = Match.team_with_avatar
      .opponent_with_avatar
      .previous_matches(Date.yesterday.end_of_day)
      .where(championship_id: current_championship.id)
      .order(date: :desc)
  end

  def sidebar
    @top_rankings = Ranking.team_with_avatar
      .top_rank
      .where(championship_id: current_championship.id)
      .order(posicao: :asc)

    @bottom_rankings = Ranking.team_with_avatar
      .bottom_rank
      .where(championship_id: current_championship.id)
      .order(posicao: :desc)

    respond_to do |format|
      format.html do
        render partial: 'index/partials/sidebar'
      end
    end
  end
end

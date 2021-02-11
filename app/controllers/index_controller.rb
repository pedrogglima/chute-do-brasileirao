# frozen_string_literal: true
class IndexController < ApplicationController
  def home
    # TODO: add champship year

    # @today_matches = Match.where(date: Date.today).order(date: :asc)
    @today_matches = Match.where(date: 1.day.from_now...30.days.from_now)
      .order(date: :desc)
      .limit(2)

    @next_matches = Match.where(date: 1.day.from_now...30.days.from_now)
      .order(date: :desc)
      .limit(5)

    @previous_matches = Match.where(date: 30.days.ago...Time.now)
      .order(date: :desc)
      .limit(5)
  end

  def sidebar
    # TODO: add champship year
    @top_rankings = Ranking.order(posicao: :asc).limit(6)
    @bottom_rankings = Ranking.order(posicao: :desc).limit(4)

    respond_to do |format|
      format.html do
        render partial: 'index/partials/sidebar'
      end
    end
  end
end

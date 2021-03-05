# frozen_string_literal: true

class IndexController < ApplicationController
  def home
    @today_matches = load_from_cache_today_matches
    @next_matches, @next_matches_pagy = load_from_cache_next_matches
    @previous_matches, @previous_matches_pagy = load_from_cache_previous_matches
  end

  def sidebar
    expires_in(1.day, public: true, stale_while_revalidate: 30.seconds)

    @top_rankings = load_from_cache_rankings(0, 5)
    @bottom_rankings = load_from_cache_rankings(16, 19)

    respond_to do |format|
      format.html do
        render partial: 'index/partials/sidebar'
      end
    end
  end

  private

  def load_from_cache_today_matches
    today_matches = TodayMatchesCaches.new

    today_matches.set(today_matches_query) unless today_matches.cached?
    today_matches.get
  end

  def load_from_cache_next_matches
    next_matches = NextMatchesCaches.new

    unless next_matches.cached?
      pagy_resources, next_matches_resources = next_matches_with_pagy_query

      next_matches.set(next_matches_resources, pagy_resources)
    end
    next_matches.get
  end

  def load_from_cache_previous_matches
    previous_matches = PreviousMatchesCaches.new

    unless previous_matches.cached?
      pagy_resources, previous_matches_resources =
        previous_matches_with_pagy_query

      previous_matches.set(previous_matches_resources, pagy_resources)
    end
    previous_matches.get
  end

  def load_from_cache_rankings(from, to)
    rankings = RankingsCaches.new

    rankings.set(rankings_query) unless rankings.cached?
    rankings.get(from, to)
  end

  def today_matches_query
    Match.team_with_avatar
         .opponent_with_avatar
         .where(date: 2.day.ago..2.days.from_now)
         .where(championship_id: current_championship.id)
         .order(date: :asc)
  end

  def next_matches_with_pagy_query
    pagy(
      Match.team_with_avatar
           .opponent_with_avatar
           .next_matches(Date.tomorrow.midnight)
           .where(championship_id: current_championship.id)
           .order(date: :asc),
      page: 1
    )
  end

  def previous_matches_with_pagy_query
    pagy(
      Match.team_with_avatar
           .opponent_with_avatar
           .previous_matches(Date.yesterday.end_of_day)
           .where(championship_id: current_championship.id)
           .order(date: :desc),
      page: 1
    )
  end

  def rankings_query
    Ranking.all
           .team_with_avatar
           .next_opponent_with_avatar
           .where(championship_id: current_championship.id)
           .order(posicao: :asc)
  end
end

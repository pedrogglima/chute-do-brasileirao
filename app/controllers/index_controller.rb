# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength
class IndexController < ApplicationController
  def home
    @today_matches = load_from_cache_today_matches
    @next_matches_pagy, @next_matches = load_from_cache_next_matches
    @previous_matches_pagy, @previous_matches = load_from_cache_previous_matches
  end

  def sidebar
    expires_in(1.day, public: true, stale_while_revalidate: 30.seconds)

    @top_rankings = load_from_cache_top_rankings
    @bottom_rankings = load_from_cache_bottom_rankings

    respond_to do |format|
      format.html do
        render partial: 'index/partials/sidebar'
      end
    end
  end

  private

  def load_from_cache_today_matches
    today_matches = TodayMatchesCache.get

    return today_matches unless today_matches.empty?

    TodayMatchesCache.set(
      today_matches_query,
      'index/partials/today_match',
      'match'
    )

    TodayMatchesCache.get
  end

  def load_from_cache_next_matches
    pagy, next_matches = NextMatchesCache.get

    return [pagy, next_matches] unless pagy.nil? || next_matches.empty?

    pagy_resources, next_matches_resources = next_matches_query

    NextMatchesCache.set(
      next_matches_resources,
      pagy_resources,
      'index/partials/next_match',
      'match'
    )

    NextMatchesCache.get
  end

  def load_from_cache_previous_matches
    pagy, previous_matches = PreviousMatchesCache.get

    return [pagy, previous_matches] unless pagy.nil? || previous_matches.empty?

    pagy_resources, previous_matches_resources = previous_matches_query

    PreviousMatchesCache.set(
      previous_matches_resources,
      pagy_resources,
      'index/partials/previous_match',
      'match'
    )

    PreviousMatchesCache.get
  end

  def load_from_cache_top_rankings
    top_rankings = TopRankingsCache.get

    return top_rankings unless top_rankings.empty?

    TopRankingsCache.set(
      top_rankings_query,
      'index/partials/top_ranking',
      'ranking'
    )

    TopRankingsCache.get
  end

  def load_from_cache_bottom_rankings
    bottom_rankings = BottomRankingsCache.get

    return bottom_rankings unless bottom_rankings.empty?

    BottomRankingsCache.set_reverse(
      bottom_rankings_query,
      'index/partials/bottom_ranking',
      'ranking'
    )

    BottomRankingsCache.get
  end

  def today_matches_query
    Match.team_with_avatar
         .opponent_with_avatar
         .today_matches
         .where(championship_id: current_championship.id)
         .order(date: :asc)
  end

  def next_matches_query
    pagy(
      Match.team_with_avatar
           .opponent_with_avatar
           .next_matches(Date.tomorrow.midnight)
           .where(championship_id: current_championship.id)
           .order(date: :asc),
      page: 1
    )
  end

  def previous_matches_query
    pagy(
      Match.team_with_avatar
           .opponent_with_avatar
           .previous_matches(Date.yesterday.end_of_day)
           .where(championship_id: current_championship.id)
           .order(date: :desc),
      page: 1
    )
  end

  def top_rankings_query
    Ranking.team_with_avatar
           .next_opponent_with_avatar
           .where(championship_id: current_championship.id)
           .order(position: :asc)
           .limit(6)
  end

  def bottom_rankings_query
    Ranking.team_with_avatar
           .next_opponent_with_avatar
           .where(championship_id: current_championship.id)
           .order(position: :desc)
           .limit(4)
  end
end
# rubocop:enable Metrics/ClassLength

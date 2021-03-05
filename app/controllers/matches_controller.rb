# frozen_string_literal: true

class MatchesController < ApplicationController
  def next_matches
    @pagy, @next_matches = next_matches_with_pagy_query

    respond_to do |format|
      format.html do
        render partial: 'index/partials/_next_matches',
               collection: @next_matches,
               as: :match,
               cached: true
      end
    end
  end

  def previous_matches
    @pagy, @previous_matches = previous_matches_with_pagy_query

    respond_to do |format|
      format.html do
        render partial: 'index/partials/_previous_matches',
               collection: @previous_matches,
               as: :match,
               cached: true
      end
    end
  end

  private

  def next_matches_with_pagy_query
    @pagy, @next_matches = pagy(
      Match.team_with_avatar
        .opponent_with_avatar
        .next_matches(Date.tomorrow.midnight)
        .where(championship_id: current_championship.id)
        .order(date: :asc),
      page: params[:page]
    )
  end

  def previous_matches_with_pagy_query
    pagy(
      Match.team_with_avatar
        .opponent_with_avatar
        .previous_matches(Date.yesterday.end_of_day)
        .where(championship_id: current_championship.id)
        .order(date: :desc),
      page: params[:page]
    )
  end
end

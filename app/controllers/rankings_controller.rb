# frozen_string_literal: true

class RankingsController < ApplicationController
  def index
    @rankings = RankingsCache.get

    return @rankings unless @rankings.empty?

    RankingsCache.set(
      resources,
      'rankings/partials/ranking',
      'ranking'
    )

    @rankings = RankingsCache.get
  end

  private

  def resources
    Ranking.all
           .team_with_avatar
           .next_opponent_with_avatar
           .where(championship_id: current_championship.id)
           .order(position: :asc)
  end
end

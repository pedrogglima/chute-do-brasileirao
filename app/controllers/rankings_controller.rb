# frozen_string_literal: true

class RankingsController < ApplicationController
  def index
    @rankings_cache = RankingsCaches.new

    @rankings = @rankings_cache.get

    return @rankings unless @rankings.empty?

    @rankings_cache.set(
      resources,
      'rankings/partials/ranking',
      'ranking'
    )

    @rankings = @rankings_cache.get
  end

  private

  def resources
    Ranking.all
           .team_with_avatar
           .next_opponent_with_avatar
           .where(championship_id: current_championship.id)
           .order(posicao: :asc)
  end
end

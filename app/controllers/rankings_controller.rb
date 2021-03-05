# frozen_string_literal: true

class RankingsController < ApplicationController
  def index
    rankings = RankingsCaches.new
    rankings.set(resources) unless rankings.cached?
    @rankings = rankings.get
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

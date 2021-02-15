# frozen_string_literal: true
class RankingsController < ApplicationController
  # TODO: add champship year
  def index
    @resources = Ranking.all
      .team_with_avatar
      .next_opponent_with_avatar
      .order(posicao: :asc)
  end
end

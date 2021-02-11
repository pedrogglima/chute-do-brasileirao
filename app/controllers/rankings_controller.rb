# frozen_string_literal: true
class RankingsController < ApplicationController
  def index
    @resources = Ranking.all.order(posicao: :asc)
  end
end

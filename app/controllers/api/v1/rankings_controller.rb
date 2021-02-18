# frozen_string_literal: true
module Api
  module V1
    class RankingsController < Api::V1::BaseController
      def index
        @rankings = Ranking.championship_relationships
          .team_with_avatar
          .next_opponent_with_avatar
          .where(championship_id: current_championship.id)
          .order(posicao: :asc)
      end
    end
  end
end

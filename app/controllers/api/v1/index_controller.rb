# frozen_string_literal: true

module Api
  module V1
    class IndexController < Api::V1::BaseController
      def home
        @today_matches = Match.team_with_avatar
          .opponent_with_avatar
          .today_matches
          .where(championship_id: current_championship.id)
          .order(date: :asc)

        @next_matches = Match.team_with_avatar
          .opponent_with_avatar
          .next_matches(Date.tomorrow.midnight)
          .where(championship_id: current_championship.id)
          .order(date: :asc)

        @previous_matches = Match.team_with_avatar
          .opponent_with_avatar
          .previous_matches(Date.yesterday.end_of_day)
          .where(championship_id: current_championship.id)
          .order(date: :desc)
      end

      def sidebar
        @top_rankings = Ranking.team_with_avatar
          .top_rank
          .where(championship_id: current_championship.id)
          .order(posicao: :asc)

        @bottom_rankings = Ranking.team_with_avatar
          .bottom_rank
          .where(championship_id: current_championship.id)
          .order(posicao: :desc)
      end
    end
  end
end

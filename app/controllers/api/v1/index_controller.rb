# frozen_string_literal: true

module Api
  module V1
    class IndexController < Api::V1::BaseController
      def home
        @today_matches = today_matches_query
        @next_matches = next_matches_query
        @previous_matches = previous_matches_query
      end

      def sidebar
        @top_rankings = top_rankings_query
        @bottom_rankings = bottom_rankings_query
      end

      private

      def today_matches_query
        Match.team_with_avatar
             .opponent_with_avatar
             .today_matches
             .where(championship_id: current_championship.id)
             .order(date: :asc)
      end

      def next_matches_query
        Match.team_with_avatar
             .opponent_with_avatar
             .next_matches(Date.tomorrow.midnight)
             .where(championship_id: current_championship.id)
             .order(date: :asc)
      end

      def previous_matches_query
        Match.team_with_avatar
             .opponent_with_avatar
             .previous_matches(Date.yesterday.end_of_day)
             .where(championship_id: current_championship.id)
             .order(date: :desc)
      end

      def top_rankings_query
        Ranking.team_with_avatar
               .top_rank
               .where(championship_id: current_championship.id)
               .order(position: :asc)
      end

      def bottom_rankings_query
        Ranking.team_with_avatar
               .bottom_rank
               .where(championship_id: current_championship.id)
               .order(position: :desc)
      end
    end
  end
end

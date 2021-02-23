# frozen_string_literal: true

module Api
  module V1
    class BetsController < Api::V1::BaseController
      before_action :authenticate!

      def index
        @bets =
          current_user.bets
                      .matches_relationships
                      .where(
                        matches: { championship_id: current_championship.id }
                      )
                      .matches_with_teams
      end

      def new
        @match = Match.team_with_avatar
                      .opponent_with_avatar
                      .find(params[:match_id])

        @bet = Bet.new
      end

      def show
        @bet = Bet.matches_with_teams.find(params[:id])
        authorize(@bet)
      end

      def create
        @bet = Bet.new(bet_params)
        @bet.user = current_user

        if @bet.save
          render(:show, status: 201)
        else
          render(json: { errors: @bet.errors.full_messages }, status: 422)
        end
      end

      private

      def bet_params
        params.require(:bet).permit(
          :match_id,
          :bet_team_score,
          :bet_opponent_score
        )
      end
    end
  end
end

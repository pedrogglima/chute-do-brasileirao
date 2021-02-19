# frozen_string_literal: true
class BetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bets = Bet
      .matches_with_teams
      .where(user_id: current_user.id)
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
      flash[:success] = 'Seu chute foi realizado com sucesso!'
      redirect_to(match_bet_path(@bet, match_id: @bet.match_id))
    else
      @match = Match.find(@bet.match_id)
      render(:new, status: 422)
    end
  end

  def bet_params
    params.require(:bet).permit(:match_id, :bet_team_score, :bet_opponent_score)
  end
end

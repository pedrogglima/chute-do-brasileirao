# frozen_string_literal: true
class BetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @match = Match.first
    @resources = Bet.all.where(user_id: current_user.id)
  end

  def new
    @match = Match.find(params[:match_id])
    @resource = Bet.new
  end

  def show
    @match = Match.find(params[:match_id])
    @resource = Bet.find(params[:id])
  end

  def create
    @resource = Bet.new(bet_params)
    @resource.user = current_user

    if @resource.save
      flash[:success] = 'Seu chute foi realizado com sucesso!'
      redirect_to(match_bet_path(@resource, match_id: @resource.match_id))
    else
      @match = Match.find(@resource.match_id)
      render(:new, status: 422)
    end
  end

  def bet_params
    params.require(:bet).permit(:match_id, :bet_team_score, :bet_opponent_score)
  end
end

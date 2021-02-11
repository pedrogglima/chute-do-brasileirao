# frozen_string_literal: true
class BetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @resources = Bet.all.where(user_id: current_user.id)
  end

  def new
    @match = Match.find(params[:match_id])
    @resource = Bet.new
  end

  def create
    @resource = Bet.new(bet_params)
    @resource.user = current_user

    if @resource.save
      flash[:success] = 'Seu chute foi realizado com sucesso!'
      redirect_to(bets_path)
    else
      @match = Match.find(@resource.match_id)
      render(:new, status: 422)
    end
  end

  def bet_params
    params.require(:bet).permit(:match_id, :score_team, :score_opponent)
  end
end

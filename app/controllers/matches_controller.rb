# frozen_string_literal: true
class MatchesController < ApplicationController
  def show
    @resource = Match.find(params[:id])
  end
end

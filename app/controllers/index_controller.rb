# frozen_string_literal: true
class IndexController < ApplicationController
  def home
    @jogos_hoje = Match.all
    @jogos_passados = Match.all
  end

  def sidebar
    respond_to do |format|
      format.html do
        render partial: 'index/partials/sidebar'
      end
    end
  end
end

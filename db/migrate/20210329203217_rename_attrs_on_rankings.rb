# frozen_string_literal: true

class RenameAttrsOnRankings < ActiveRecord::Migration[6.1]
  def change
    rename_column :rankings, :posicao, :position
    rename_column :rankings, :pontos, :points
    rename_column :rankings, :jogos, :played
    rename_column :rankings, :vitorias, :won
    rename_column :rankings, :empates, :drawn
    rename_column :rankings, :derrotas, :lost
    rename_column :rankings, :gols_pro, :goals_for
    rename_column :rankings, :gols_contra, :goals_against
    rename_column :rankings, :saldo_de_gols, :goal_difference
    rename_column :rankings, :cartoes_amarelos, :yellow_card
    rename_column :rankings, :cartoes_vermelhos, :red_card
    rename_column :rankings, :aproveitamento, :advantages
    rename_column :rankings, :recentes, :form
  end
end

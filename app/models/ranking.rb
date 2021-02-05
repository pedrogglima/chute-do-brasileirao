# frozen_string_literal: true
class Ranking < ApplicationRecord
  belongs_to :championship
  belongs_to :team
  belongs_to :next_opponent, class_name: "Team", foreign_key: "next_opponent_id"

  validates :posicao,
            presence: true,
            numericality: { only_integer: true },
            inclusion: 1..20
  validates :pontos, presence: true
  validates :jogos, presence: true
  validates :vitorias, presence: true
  validates :empates, presence: true
  validates :derrotas, presence: true
  validates :gols_pro, presence: true
  validates :gols_contra, presence: true
  validates :saldo_de_gols, presence: true
  validates :cartoes_amarelos, presence: true
  validates :cartoes_vermelhos, presence: true
  validates :aproveitamento, presence: true
  validates :recentes, presence: true
end
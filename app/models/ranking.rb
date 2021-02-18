# frozen_string_literal: true
class Ranking < ApplicationRecord
  # associations
  #
  belongs_to :championship
  belongs_to :team
  belongs_to :next_opponent, class_name: "Team", foreign_key: "next_opponent_id"

  # validations
  #
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

  # scopes
  #
  scope :top_rank, -> { limit(6) }
  scope :bottom_rank, -> { limit(4) }
  # To avoid n+1 issue
  scope :championship_relationships, -> {
    joins(championship: { league: :division })
  }
  scope :team_with_avatar, -> { includes(team: { avatar_attachment: :blob }) }
  scope :next_opponent_with_avatar, -> {
    includes(next_opponent: { avatar_attachment: :blob })
  }
end

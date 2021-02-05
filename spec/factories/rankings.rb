# frozen_string_literal: true
require 'securerandom'

FactoryBot.define do
  factory :ranking do
    association :championship
    association :team, name: "team"
    association :next_opponent, factory: :team, name: "opponent"

    posicao { 10 }
    pontos { 10 }
    jogos { 10 }
    vitorias { 10 }
    empates { 10 }
    derrotas { 10 }
    gols_pro { 10 }
    gols_contra { 10 }
    saldo_de_gols { 10 }
    cartoes_amarelos { 10 }
    cartoes_vermelhos { 10 }
    aproveitamento { 10 }
    recentes { "VVV" }
  end
end

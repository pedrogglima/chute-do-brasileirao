# frozen_string_literal: true
championship = Championship.find_by(year: 2020)
team_1 = Team.find_by(name: "São Paulo")
team_2 = Team.find_by(name: "Bahia")

Ranking.create!(
  championship: championship,
  team: team_1,
  next_opponent: team_2,
  posicao: 1,
  pontos: 1,
  jogos: 1,
  vitorias: 1,
  empates: 1,
  derrotas: 1,
  gols_pro: 1,
  gols_contra: 1,
  saldo_de_gols: 1,
  cartoes_amarelos: 1,
  cartoes_vermelhos: 1,
  aproveitamento: 1,
  recentes: 1,
)

Ranking.create!(
  championship: championship,
  team: team_2,
  next_opponent: team_1,
  posicao: 2,
  pontos: 1,
  jogos: 1,
  vitorias: 1,
  empates: 1,
  derrotas: 1,
  gols_pro: 1,
  gols_contra: 1,
  saldo_de_gols: 1,
  cartoes_amarelos: 1,
  cartoes_vermelhos: 1,
  aproveitamento: 1,
  recentes: 1,
)

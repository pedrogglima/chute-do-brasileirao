# frozen_string_literal: true
json.call(
  ranking,
  :id,
  :posicao,
  :pontos,
  :jogos,
  :vitorias,
  :empates,
  :derrotas,
  :gols_pro,
  :gols_contra,
  :saldo_de_gols,
  :cartoes_amarelos,
  :cartoes_vermelhos,
  :aproveitamento,
  :recentes
)

json.team do
  json.partial!('api/v1/teams/partials/team', team: ranking.team)
end

json.next_opponent do
  json.partial!('api/v1/teams/partials/team', team: ranking.next_opponent)
end

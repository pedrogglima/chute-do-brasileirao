# frozen_string_literal: true

class RankingsCaches < ListCaches
  def initialize(key = 'rankings', from = 0, to = -1)
    super
  end

  private

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def to_json(ranking)
    {
      id: ranking.id,
      posicao: ranking.posicao,
      team_avatar: extract_url(ranking.team.avatar),
      team_name: ranking.team.name,
      next_opponent_avatar:
        nil_or_next_opponent_avatar(ranking.next_opponent),
      next_opponent_name:
        nil_or_next_opponent_name(ranking.next_opponent),
      pontos: ranking.pontos,
      jogos: ranking.jogos,
      vitorias: ranking.vitorias,
      empates: ranking.empates,
      derrotas: ranking.derrotas,
      gols_pro: ranking.gols_pro,
      gols_contra: ranking.gols_contra,
      saldo_de_gols: ranking.saldo_de_gols,
      cartoes_amarelos: ranking.cartoes_amarelos,
      cartoes_vermelhos: ranking.cartoes_vermelhos,
      aproveitamento: ranking.aproveitamento,
      recentes: ranking.recentes
    }.to_json
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def nil_or_next_opponent_name(next_opponent)
    next_opponent ? next_opponent.name : nil
  end

  def nil_or_next_opponent_avatar(next_opponent)
    next_opponent ? extract_url(next_opponent.avatar) : nil
  end
end
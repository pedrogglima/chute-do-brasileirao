# frozen_string_literal: true

require_relative 'base/list_caches'

class RankingsCaches < ListCaches
  KEY = 'rankings_list'

  def initialize(from = 0, to = -1)
    super(KEY, from, to)
  end

  private

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def to_json(ranking)
    {
      id: ranking.id,
      posicao: ranking.posicao,
      team_avatar: extract_variant_url(
        ranking.team.avatar.variant(resize_to_limit: [26, 26])
      ),
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
    return unless next_opponent

    extract_variant_url(
      next_opponent.avatar.variant(resize_to_limit: [26, 26])
    )
  end
end

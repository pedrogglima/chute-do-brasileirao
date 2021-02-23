# frozen_string_literal: true

module Cache
  class RankingsService < Cache::Base::ListService
    KEY = 'ranking_list'
    
    def call
      res = list(KEY, FROM, TO)

      return res unless res.empty?

      load_resources(KEY)
      list(KEY, FROM, TO)
    end

    protected

    def resources
      Ranking.all
             .team_with_avatar
             .next_opponent_with_avatar
             .where(championship_id: @params[:current_championship_id])
             .order(posicao: :asc)
    end

    def to_json(ranking)
      {
        id: ranking.id,
        posicao: ranking.posicao,
        team_avatar: extract_url(ranking.team.avatar),
        team_name: ranking.team.name,
        next_opponent_avatar: extract_url(ranking.next_opponent.avatar),
        next_opponent_name: ranking.next_opponent.name,
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
  end
end

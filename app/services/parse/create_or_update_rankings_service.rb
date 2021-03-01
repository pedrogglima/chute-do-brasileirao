# frozen_string_literal: true

module Parse
  class CreateOrUpdateRankingsService < ApplicationService
    def initialize(rankings)
      @rankings = rankings
    end

    def call
      @rankings.each do |ranking_hash|
        create_or_update(ranking_hash)
      end
    end

    private

    def create_or_update(ranking_hash)
      ranking = find_ranking(ranking_hash['posicao'])
      team = find_team_by_name(ranking_hash['team'])
      next_opponent = find_team_by_name(ranking_hash['next_opponent'])

      if ranking
        update(ranking, ranking_hash, team, next_opponent)
      else
        create(ranking_hash, team, next_opponent)
      end
    end

    def current_championship
      GlobalSetting.singleton.championship
    end

    def find_ranking(posicao)
      Ranking.where(
        posicao: posicao,
        championship_id: current_championship.id
      ).first
    end

    def find_team_by_name(name)
      Team.find_by(name: name)
    end

    def nil_or_next_opponent(next_opponent)
      next_opponent ? next_opponent.id : nil
    end

    # rubocop:disable Metrics/MethodLength
    def update(ranking, ranking_hash, team, next_opponent)
      ranking.update!(
        team_id: team.id,
        pontos: ranking_hash['pontos'],
        jogos: ranking_hash['jogos'],
        vitorias: ranking_hash['vitorias'],
        empates: ranking_hash['empates'],
        derrotas: ranking_hash['derrotas'],
        gols_pro: ranking_hash['gols_pro'],
        gols_contra: ranking_hash['gols_contra'],
        saldo_de_gols: ranking_hash['saldo_de_gols'],
        cartoes_amarelos: ranking_hash['cartoes_amarelos'],
        cartoes_vermelhos: ranking_hash['cartoes_vermelhos'],
        aproveitamento: ranking_hash['aproveitamento'],
        recentes: ranking_hash['recentes'],
        next_opponent_id: nil_or_next_opponent(next_opponent)
      )
    end

    # rubocop:disable Metrics/AbcSize
    def create(ranking_hash, team, next_opponent)
      Ranking.create!(
        championship_id: current_championship.id,
        posicao: ranking_hash['posicao'].to_i,
        team_id: team.id,
        pontos: ranking_hash['pontos'],
        jogos: ranking_hash['jogos'],
        vitorias: ranking_hash['vitorias'],
        empates: ranking_hash['empates'],
        derrotas: ranking_hash['derrotas'],
        gols_pro: ranking_hash['gols_pro'],
        gols_contra: ranking_hash['gols_contra'],
        saldo_de_gols: ranking_hash['saldo_de_gols'],
        cartoes_amarelos: ranking_hash['cartoes_amarelos'],
        cartoes_vermelhos: ranking_hash['cartoes_vermelhos'],
        aproveitamento: ranking_hash['aproveitamento'],
        recentes: ranking_hash['recentes'],
        next_opponent_id: nil_or_next_opponent(next_opponent)
      )
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength
  end
end

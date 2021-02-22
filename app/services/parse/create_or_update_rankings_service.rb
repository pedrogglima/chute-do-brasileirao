# frozen_string_literal: true

module Parse
  class CreateOrUpdateRankingsService < ApplicationService
    def initialize(rankings)
      @rankings = rankings
    end

    def call
      championship = GlobalSetting.singleton.championship

      @rankings.each do |r|
        ranking = Ranking.where(
          posicao: r["posicao"],
          championship_id: championship.id
        ).first  
        
        team = Team.find_by(name: r["team"])
        next_opponent = Team.find_by(name: r["next_opponent"])
        
        if ranking
          update(ranking, r, team, next_opponent)
        else
          create(r, championship.id, team, next_opponent)
        end
      end
    end

    private

    def update(obj, ranking, team, next_opponent)
      obj.update!(
        team_id: team.id,
        pontos:  ranking["pontos"],
        jogos:  ranking["jogos"],
        vitorias:  ranking["vitorias"],
        empates:  ranking["empates"],
        derrotas:  ranking["derrotas"],
        gols_pro:  ranking["gols_pro"],
        gols_contra:  ranking["gols_contra"],
        saldo_de_gols:  ranking["saldo_de_gols"],
        cartoes_amarelos:  ranking["cartoes_amarelos"],
        cartoes_vermelhos:  ranking["cartoes_vermelhos"],
        aproveitamento:  ranking["aproveitamento"],
        recentes:  ranking["recentes"],
        next_opponent_id: next_opponent.id
      )
    end

    def create(ranking, champ_id, team, next_opponent)
      Ranking.create!(
        championship_id: champ_id,
        posicao: ranking["posicao"].to_i,
        team_id: team.id,
        pontos:  ranking["pontos"],
        jogos:  ranking["jogos"],
        vitorias:  ranking["vitorias"],
        empates:  ranking["empates"],
        derrotas:  ranking["derrotas"],
        gols_pro:  ranking["gols_pro"],
        gols_contra:  ranking["gols_contra"],
        saldo_de_gols:  ranking["saldo_de_gols"],
        cartoes_amarelos:  ranking["cartoes_amarelos"],
        cartoes_vermelhos:  ranking["cartoes_vermelhos"],
        aproveitamento:  ranking["aproveitamento"],
        recentes:  ranking["recentes"],
        next_opponent_id: next_opponent.id
      )
    end
  end
end

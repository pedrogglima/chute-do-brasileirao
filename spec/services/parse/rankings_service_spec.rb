# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Parse::CreateOrUpdateRankingsService, type: :service) do
  let!(:global_setting) { create(:global_setting) }
  let!(:championship) { global_setting.championship }
  let!(:ranking) do
    create(:ranking, posicao: 1, pontos: 10, championship: championship)
  end
  let(:ranking_attrs) { attributes_for(:ranking, posicao: 2) }
  let!(:team) { create(:team) }
  let!(:next_opponent) { create(:team) }
  let(:updated_pontos) { 15 }

  let(:rankings) do
    [
      {
        'posicao' => ranking.posicao,
        'team' => team.name,
        'pontos' => updated_pontos,
        'jogos' => ranking.jogos,
        'vitorias' => ranking.vitorias,
        'empates' => ranking.empates,
        'derrotas' => ranking.derrotas,
        'gols_pro' => ranking.gols_pro,
        'gols_contra' => ranking.gols_contra,
        'saldo_de_gols' => ranking.saldo_de_gols,
        'cartoes_amarelos' => ranking.cartoes_amarelos,
        'cartoes_vermelhos' => ranking.cartoes_vermelhos,
        'aproveitamento' => ranking.aproveitamento,
        'recentes' => ranking.recentes,
        'next_opponent' => next_opponent.name
      },
      {
        'posicao' => ranking_attrs[:posicao],
        'team' => team.name,
        'pontos' => ranking_attrs[:pontos],
        'jogos' => ranking_attrs[:jogos],
        'vitorias' => ranking_attrs[:vitorias],
        'empates' => ranking_attrs[:empates],
        'derrotas' => ranking_attrs[:derrotas],
        'gols_pro' => ranking_attrs[:gols_pro],
        'gols_contra' => ranking_attrs[:gols_contra],
        'saldo_de_gols' => ranking_attrs[:saldo_de_gols],
        'cartoes_amarelos' => ranking_attrs[:cartoes_amarelos],
        'cartoes_vermelhos' => ranking_attrs[:cartoes_vermelhos],
        'aproveitamento' => ranking_attrs[:aproveitamento],
        'recentes' => ranking_attrs[:recentes],
        'next_opponent' => next_opponent.name
      }
    ]
  end

  let(:parse_resources_service) do
    Parse::CreateOrUpdateRankingsService.new(rankings)
  end

  describe '#call' do
    subject { parse_resources_service.call }

    # p.s let!(:resource) create outside scope of expect, resulting in 1 count
    it "should create only if it doesn't exist" do
      expect { parse_resources_service.call }.to(change { Ranking.count }.by(1))
    end

    it 'should update if exist' do
      parse_resources_service.call
      expect(ranking.reload.pontos).to(eq(updated_pontos))
    end
  end
end

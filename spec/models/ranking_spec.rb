# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Ranking, type: :model) do
  let!(:ranking) { create :ranking }

  describe 'associations' do
    it { should belong_to(:championship) }
    it { should belong_to(:team) }
    it { should belong_to(:next_opponent) }
  end

  describe 'validations' do
    it { should validate_presence_of(:posicao) }
    it { should validate_numericality_of(:posicao) }
    it { should validate_inclusion_of(:posicao).in_range(1..20) }
    it { should validate_presence_of(:pontos) }
    it { should validate_presence_of(:jogos) }
    it { should validate_presence_of(:vitorias) }
    it { should validate_presence_of(:empates) }
    it { should validate_presence_of(:derrotas) }
    it { should validate_presence_of(:gols_pro) }
    it { should validate_presence_of(:gols_contra) }
    it { should validate_presence_of(:saldo_de_gols) }
    it { should validate_presence_of(:cartoes_amarelos) }
    it { should validate_presence_of(:cartoes_vermelhos) }
    it { should validate_presence_of(:aproveitamento) }
    it { should validate_presence_of(:recentes) }
  end

  describe 'attributes' do
    context 'with valid params' do
      it { expect(ranking).to(be_valid) }
    end
  end
end

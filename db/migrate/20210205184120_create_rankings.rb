# frozen_string_literal: true
# frozen_integer_literal: true
class CreateRankings < ActiveRecord::Migration[6.1]
  def change
    create_table :rankings do |t|
      t.references(:championship, null: false, foreign_key: true)
      t.references(:team, null: false, foreign_key: true)
      t.references(:next_opponent, null: false, foreign_key: { to_table: :teams })
      t.integer(:posicao, null: false)
      t.integer(:pontos)
      t.integer(:jogos)
      t.integer(:vitorias)
      t.integer(:empates)
      t.integer(:derrotas)
      t.integer(:gols_pro)
      t.integer(:gols_contra)
      t.integer(:saldo_de_gols)
      t.integer(:cartoes_amarelos)
      t.integer(:cartoes_vermelhos)
      t.integer(:aproveitamento)
      t.string(:recentes)
      t.timestamps
    end
  end
end

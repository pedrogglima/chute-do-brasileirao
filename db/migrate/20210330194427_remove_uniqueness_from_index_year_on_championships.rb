# frozen_string_literal: true

class RemoveUniquenessFromIndexYearOnChampionships < ActiveRecord::Migration[6.1]
  def change
    remove_index :championships, name: 'index_championships_on_year'
    add_index :championships, :year
  end
end

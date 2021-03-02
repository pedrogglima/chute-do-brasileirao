# frozen_string_literal: true

class AddColumnNumberOfMatchesToChampionships < ActiveRecord::Migration[6.1]
  def change
    add_column :championships,
               :number_of_matches,
               :integer,
               null: false,
               default: 380
  end
end

# frozen_string_literal: true
class AddIndexOnIdMatchAndChampionshipIdOnMatch < ActiveRecord::Migration[6.1]
  def change
    add_reference(:rankings, [:championship_id, :id_match], unique: true)
  end
end

# frozen_string_literal: true
class AddReferencesDivisionToLeagues < ActiveRecord::Migration[6.1]
  def change
    add_reference(:leagues, :division)
  end
end

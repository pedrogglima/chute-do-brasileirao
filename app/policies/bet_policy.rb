# frozen_string_literal: true
class BetPolicy < ApplicationPolicy
  def show?
    return true if user.id == bet.user_id
  end

  private

  def bet
    record
  end
end

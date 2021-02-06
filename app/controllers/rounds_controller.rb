# frozen_string_literal: true
class RoundsController < ApplicationController
  def index
    @resources = Round.joins(:matches)
  end
end

# frozen_string_literal: true
class ApplicationController < ActionController::Base
  include Pundit

  # get current championship from singleton class
  def current_championship
    GlobalSetting.singleton.championship
  end
end

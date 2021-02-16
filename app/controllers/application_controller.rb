# frozen_string_literal: true
class ApplicationController < ActionController::Base
  include Pundit

  # rubocop:disable Layout/LineLength
  #
  # Define the championship instance used to query rankings, matches, etc, displayed to the user. In other words, users have only access to associations of the current championship.
  #
  # rubocop:enable Layout/LineLength
  #
  def current_championship
    GlobalSetting.singleton.championship
  end
end

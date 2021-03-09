# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit

  def current_championship
    @current_championship = GlobalSetting.singleton.championship
  end

  def unauthorize
    raise ActionController::RoutingError, 'Unauthorize access'
  end
end

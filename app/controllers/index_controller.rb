# frozen_string_literal: true
class IndexController < ApplicationController
  def home
  end

  def sidebar
    respond_to do |format|
      format.html do
        render partial: 'index/sidebar'
      end
    end
  end
end

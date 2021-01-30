# frozen_string_literal: true
Rails.application.routes.draw do
  get '/', to: 'index#home'
  get 'sidebar', to: 'index#sidebar'
end

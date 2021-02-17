# frozen_string_literal: true
Rails.application.routes.draw do
  # TODO: add auth for access
  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    namespace :v1 do
      post '/login', to: 'authentication#login'
      delete '/logout', to: 'authentication#logout'
    end
  end

  root to: 'index#home'
  get 'sidebar', to: 'index#sidebar'

  scope(path_names: { new: 'novo', edit: 'editar', password: 'senha' }) do
    devise_for :users,
      path: 'usuario',
      class_name: "User",
      controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations',
        passwords: 'users/passwords',
      },
      path_names: {
        sign_in: 'entrar',
        sign_out: 'sair',
        sign_up: 'cadastrar-se',
        confirmation: 'verificacao-email',
      }
  end

  scope(path_names: {
    new: 'novo',
    edit: 'editar',
    create: 'criar',
    update: 'atualizar',
    destroy: 'deletar',
  }) do
    resources :tabelas,
            controller: 'rankings',
            as: 'rankings',
            only: [:index]

    resources :rodadas,
              controller: 'rounds',
              as: 'rounds',
              only: [:index]

    resources :partidas, as: 'matches', only: [] do
      resources :chutes,
                controller: 'bets',
                as: 'bets',
                only: [:new, :show]
    end

    resources :chutes,
                controller: 'bets',
                as: 'bets',
                only: [:index, :create]
  end
end

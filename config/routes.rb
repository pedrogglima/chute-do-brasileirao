# frozen_string_literal: true

Rails.application.routes.draw do
  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  namespace :api do
    namespace :v1 do
      scope(path_names: {
              new: 'novo',
              edit: 'editar',
              create: 'criar',
              update: 'atualizar',
              destroy: 'deletar'
            }) do
        get 'index', to: 'index#home'
        get 'sidebar', to: 'index#sidebar'

        resources :usuarios,
                  controller: 'users',
                  as: 'users',
                  only: %i[create show]

        scope path: 'usuario', as: 'user' do
          post 'senha/novo', to: 'password#new', as: 'password/new'
          put 'senha/editar', to: 'password#edit', as: 'password/edit'
          post '/entrar', to: 'authentication#login', as: 'login'
          delete '/sair', to: 'authentication#logout', as: 'logout'
        end

        resources :chutes,
                  controller: 'bets',
                  as: 'bets',
                  only: %i[index create]

        resources :partidas, as: 'matches', only: [] do
          resources :chutes,
                    controller: 'bets',
                    as: 'bets',
                    only: %i[new show]
        end

        resources :tabelas,
                  controller: 'rankings',
                  as: 'rankings',
                  only: %i[index]
      end
    end
  end

  root to: 'index#home'
  get 'sidebar', to: 'index#sidebar'

  scope(path_names: { new: 'novo', edit: 'editar', password: 'senha' }) do
    devise_for :users,
               path: 'usuario',
               class_name: 'User',
               controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations',
                 passwords: 'users/passwords',
                 omniauth_callbacks: 'users/omniauth_callbacks'
               },
               path_names: {
                 sign_in: 'entrar',
                 sign_out: 'sair',
                 sign_up: 'cadastrar-se',
                 confirmation: 'verificacao-email'
               }
  end

  scope(path_names: {
          new: 'novo',
          edit: 'editar',
          create: 'criar',
          update: 'atualizar',
          destroy: 'deletar'
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
                only: %i[new show]
    end

    resources :chutes,
              controller: 'bets',
              as: 'bets',
              only: %i[index create]
  end
end

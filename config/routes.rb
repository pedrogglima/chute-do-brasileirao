# frozen_string_literal: true
Rails.application.routes.draw do
  root to: 'index#home'
  get 'sidebar', to: 'index#sidebar'

  scope(path_names: { new: 'novo', edit: 'editar', password: 'senha' }) do
    devise_for :users,
      path: 'usuario',
      class_name: "User",
      controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations',
      },
      path_names: {
        sign_in: 'entrar',
        sign_out: 'sair',
        sign_up: 'cadastrar-se',
        confirmation: 'verificacao-email',
      }
  end

  scope(path: 'serie-a/', path_names: {
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

    resources :partidas,
              controller: 'matches',
              as: 'matches',
              only: [:show]

    resources :chutes,
              controller: 'bets',
              as: 'bets',
              only: [:index, :new, :create]
  end
end

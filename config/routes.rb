# frozen_string_literal: true
Rails.application.routes.draw do
  get '/', to: 'index#home'
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
end

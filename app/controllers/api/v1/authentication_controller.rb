# frozen_string_literal: true

module Api
  module V1
    class AuthenticationController < Api::V1::BaseController
      before_action :authenticate!, only: %i[logout]
      before_action :find_user_by_email!, only: %i[login]

      def login
        if @user&.valid_password?(params[:password])
          generate_token_and_set_to_header(@user)
          render(
            partial: 'api/v1/users/partials/user',
            locals: { user: @user },
            status: 200
          )
        else
          render(json: { error: invalid_credential_message }, status: 401)
        end
      end

      def logout
        if logged_in?
          current_user.update_attribute(:jti, SecureRandom.uuid)
          render(json: { message: 'Saiu com sucesso.' }, status: 200)
        else
          render(json: { error: 'Unauthorize' }, status: 401)
        end
      end

      private

      def find_user_by_email!
        @user = User.find_by(email: params[:email])
      end

      def invalid_credential_message
        'Log in falhou! Usuário ou senha incorreto.'
      end
    end
  end
end

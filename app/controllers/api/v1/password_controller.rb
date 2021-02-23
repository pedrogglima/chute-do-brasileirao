# frozen_string_literal: true

module Api
  module V1
    class PasswordController < Api::V1::BaseController
      before_action :find_user_by_email!, only: %i[new]

      def new
        update_with_new_token(@user)

        PasswordMailer.with(user: @user).reset_password.deliver_later

        render(json: { success: success_message }, status: 200)
      end

      def edit
        @user = User.with_active_reset_password(params[:reset_password_token])
        if valid_new_password?
          reset_password(@user)

          @user.update(reset_password_token: nil, reset_password_sent_at: nil)

          generate_token_and_set_to_header(@user)
          render(:show, status: 201)
        else
          render(json: { error: error_message }, status: 422)
        end
      end

      private

      def find_user_by_email!
        @user = User.find_by!(email: params[:email])

        return if @user

        render(json: { error: 'Usuário não encontrado.' }, status: 404)
      end

      def valid_new_password?
        params[:new_password].present? &&
          params[:new_password] == params[:new_password_confirmation]
      end

      def update_with_new_token(user)
        user.update(
          {
            reset_password_token: SecureRandom.uuid,
            reset_password_sent_at: Time.now
          }
        )
      end

      def reset_password(user)
        user.reset_password(
          params[:new_password],
          params[:new_password_confirmation]
        )
      end

      def success_message
        'Dentro de minutos, você receberá um e-mail' \
            ' com instruções para a troca da sua senha.'
      end

      def error_message
        'Senha diferente de Confirmação senha.'
      end
    end
  end
end

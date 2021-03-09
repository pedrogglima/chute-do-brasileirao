# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def twitter
      @user = User.from_omniauth(from_provider_params)
      if @user.persisted?
        sign_out_all_scopes
        flash_message_success('Twitter')
        sign_in_and_redirect @user, event: :authentication
      else
        flash_message_failure('Twitter', auth.info.email)
        redirect_to new_user_session_url
      end
    end

    def google_oauth2
      @user = User.from_omniauth(from_provider_params)

      if @user.persisted?
        sign_out_all_scopes
        flash_message_success('Google')
        sign_in_and_redirect @user, event: :authentication
      else
        flash_message_failure('Google', auth.info.email)
        redirect_to new_user_session_url
      end
    end

    protected

    def after_omniauth_failure_path_for(_scope)
      new_user_session_url
    end

    private

    def flash_message_success(kind)
      flash[:success] = t 'devise.omniauth_callbacks.success', kind: kind
    end

    def flash_message_failure(kind, email)
      flash[:alert] = t 'devise.omniauth_callbacks.failure',
                        kind: kind,
                        reason: "#{email} não está autorizado."
    end

    def from_provider_params
      @from_provider_params ||= {
        provider: auth.provider,
        uid: auth.uid,
        email: auth.info.email,
        name: auth.info.name
      }
    end

    def auth
      @auth ||= request.env['omniauth.auth']
    end
  end
end

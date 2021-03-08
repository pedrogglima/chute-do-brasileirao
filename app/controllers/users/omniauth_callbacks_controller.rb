# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    # You should configure your model like this:
    # devise :omniauthable, omniauth_providers: [:twitter]

    # You should also create an action method in this controller like this:
    def twitter
      @user = User.from_omniauth(from_provider_params)

      if @user.persisted?
        sign_out_all_scopes

        sign_in_and_redirect @user, event: :authentication
        flash_message_success
      else
        session['devise.twitter_data'] =
          auth.except('extra')
        redirect_to new_user_registration_url
      end
    end

    def google_oauth2
      @user = User.from_omniauth(from_provider_params)

      if @user.persisted?
        sign_out_all_scopes

        sign_in_and_redirect @user, event: :authentication

        flash_message_success
      else
        session['devise.google_oauth2_data'] =
          auth.except('extra')
        redirect_to new_user_registration_url
      end
    end

    # More info at:
    # https://github.com/heartcombo/devise#omniauth

    # GET|POST /resource/auth/twitter
    # def passthru
    #   super
    # end

    # GET|POST /users/auth/twitter/callback
    def failure
      redirect_to root_path
    end

    # protected

    # The path used when OmniAuth fails
    # def after_omniauth_failure_path_for(scope)
    #   super(scope)
    # end

    private

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

    def flash_message_success
      return unless is_navigational_format?

      set_flash_message(:notice, :success, kind: 'Twitter')
    end
  end
end

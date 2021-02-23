# frozen_string_literal: true

module Api
  module V1
    class BaseController < ActionController::API
      include Pundit

      rescue_from ActiveRecord::RecordNotFound,
                  with: :handle_record_not_found_error

      rescue_from Pundit::NotAuthorizedError,
                  with: :handle_access_denied_error

      respond_to :json

      protected

      # rubocop:disable Layout/LineLength
      #
      # Define the championship instance used to query rankings, matches, etc, displayed to the user. In other words, users have only access to associations of the current championship.
      #
      # rubocop:enable Layout/LineLength
      #
      def current_championship
        @current_championship = GlobalSetting.singleton.championship
      end

      def auth_header
        request.headers['Authorization']
      end

      def generate_token_and_set_to_header(user)
        token = Users::TokenCreatorService.call(user)
        response.set_header('Authorization', "Bearer #{token}")
      end

      def current_user
        @user = Users::TokenDecryptorService.call(auth_header)
      end

      def logged_in?
        current_user.present?
      end

      def authenticate!
        return if logged_in?

        render(
          json: { message: 'Para continuar, efetue login ou registre-se.' },
          status: 401
        )
      end

      private

      def handle_record_not_found_error(error)
        render(json: { error: error.to_s }, status: 404)
      end

      def handle_access_denied_error(error)
        render(json: { error: error.to_s }, status: 401)
      end
    end
  end
end

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

      private

      def handle_record_not_found_error(e)
        render(json: { error: e.to_s }, status: 404)
      end

      def handle_access_denied_error(e)
        render(json: { error: e.to_s }, status: 401)
      end
    end
  end
end

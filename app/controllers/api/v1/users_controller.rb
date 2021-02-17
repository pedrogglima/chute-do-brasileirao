# frozen_string_literal: true

module Api
  module V1
    class UsersController < BaseController
      before_action :authenticate!, only: %i[show]

      def create
        @user = User.new(user_params)
        if @user.save
          generate_token_and_set_to_header(@user)
          render(:show, status: 201)
        else
          render(json: { errors: @user.errors.full_messages }, status: 422)
        end
      end

      def show; end

      private

      def user_params
        params.permit(:email, :password, :first_name, :last_name)
      end
    end
  end
end

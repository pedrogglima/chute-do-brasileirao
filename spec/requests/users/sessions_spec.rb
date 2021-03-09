# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Users::SessionsController, type: :request) do
  setup do
    describe 'GET /new' do
      it 'returns http success' do
        get new_user_session_path
        expect(response).to(have_http_status(:success))
      end
    end

    describe 'Post /create' do
      it 'returns http 404' do
        expect { post user_session_path }.to(
          raise_error(ActionController::RoutingError)
        )
      end
    end
  end
end

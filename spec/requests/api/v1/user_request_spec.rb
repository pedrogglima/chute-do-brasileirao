# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Api::V1::UsersController, type: :request) do
  let(:user_params) do
    {
      "email": 'anon@anon.com',
      "password": 'password',
      "first_name": 'Anonimus',
      "last_name": 'Nope'
    }
  end

  setup_api do
    describe 'POST api/v1/users#create' do
      subject { post api_v1_users_path(params: user_params, format: :json) }

      context 'correct params are passed' do
        it 'has some additional info about user' do
          subject
          expect(JSON.parse(response.body)).to(include_json(
                                                 "email": 'anon@anon.com',
                                                 "first_name": 'Anonimus',
                                                 "last_name": 'Nope'
                                               ))
        end

        it 'returns created successfuly' do
          subject
          expect(response).to(have_http_status(201))
        end

        it 'adds new object to db' do
          expect { subject }.to(change(User, :count).by(1))
        end

        it 'has header with new token' do
          subject
          expect(response.header['Authorization']).to(be_present)
        end
      end

      context 'incorrect params are passed' do
        let(:user_params) do
          {
            "email": 'anon@anon.com',
            "password": '',
            "first_name": 'Anonimus',
            "last_name": 'Nope'
          }
        end
        it 'returns error Unprocessable Entity' do
          subject
          expect(response).to(have_http_status(422))
        end

        it "hasn\'t token inside header" do
          subject
          expect(response.header['Authorization']).to_not(be_present)
        end

        it "hasn\'t token inside body" do
          subject
          expect(response.body['Authorization']).to_not(be_present)
        end

        it 'doesn\'t create new object' do
          expect { subject }.to(change(User, :count).by(0))
        end

        it 'returns correct error message' do
          subject
          expect(JSON.parse(response.body)['errors']).to(
            eq(['Senha não pode ficar em branco'])
          )
        end
      end
    end

    describe 'GET api/v1/user#show' do
      context 'correct params are passed' do
        subject do
          get api_v1_user_path(id: @user.id, format: :json), headers: @token
        end

        it 'has some additional info about user' do
          subject
          expect(
            JSON.parse(response.body)
          ).to(
            eq(
              'id' => @user.id,
              'email' => @user.email,
              'first_name' => @user.first_name,
              'last_name' => @user.last_name,
              'created_at' => @user.created_at.strftime('%FT%T.%L%:z'),
              'updated_at' => @user.updated_at.strftime('%FT%T.%L%:z')
            )
          )
        end

        it 'returns correct status' do
          subject
          expect(response).to(have_http_status(200))
        end
      end

      context 'incorrect params are passed' do
        subject do
          get api_v1_user_path(
            id: @user.id,
            format: :json
          ),
              headers: { Authorization: 'Token 123' }
        end

        it 'returns error Unauthorized' do
          subject
          expect(response).to(have_http_status(401))
        end

        it 'returns correct error message' do
          subject
          expect(JSON.parse(response.body)['message']).to(
            eq('Para continuar, efetue login ou registre-se.')
          )
        end
      end
    end
  end
end

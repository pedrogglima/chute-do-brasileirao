# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Users::TokenDecryptorService) do
  let!(:user) { create(:user) }
  let(:token_new) { Users::TokenCreatorService.call(user) }
  let!(:decrypt_service) { Users::TokenDecryptorService.new(token) }

  describe "#call" do
    subject { decrypt_service.call }

    context 'token are successfully decrypted' do
      let!(:token) do
        { "Authorization" => "Bearer #{token_new}" }.to_s
      end

      it 'tokens are valid ' do
        expect do
          JWT.decode(
            token_new,
            Rails.application.secrets.secret_key_base,
            true,
            algorithm: 'HS256'
          )
        end.to_not(raise_error)
      end

      it 'updated user jti values' do
        subject
        expect(user.jti).not_to(be_nil)
      end

      it 'returns user' do
        expect(subject).to(eq(User.find_by(email: user.email)))
      end
    end

    context 'error occurred with decryption' do
      let!(:token) do
        { "Authorization" => "Bearer #{token_new}ivalid" }.to_s
      end

      it 'tokens are valid ' do
        expect do
          JWT.decode(
            token,
            Rails.application.secrets.secret_key_base,
            true,
            algorithm: 'HS256'
          )
        end.to(raise_error(JWT::DecodeError))
      end

      it 'return nil' do
        expect(subject).to(be_nil)
      end
    end
  end
end

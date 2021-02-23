# frozen_string_literal: true

module Users
  class TokenDecryptorService < ApplicationService
    def initialize(auth_header)
      @decoded_hash = decoded_token(auth_header)
    end

    def call
      return if @decoded_hash.nil?

      user = User.find_by(id: user_id)
      user if exp > Time.now.to_i && jti == user.jti
    end

    private

    def user_id
      @decoded_hash[0]['user_id'] unless @decoded_hash.nil?
    end

    def exp
      @decoded_hash[0]['exp'] unless @decoded_hash.nil?
    end

    def jti
      @decoded_hash[0]['jti'] unless @decoded_hash.nil?
    end

    def decoded_token(auth_header)
      return unless auth_header

      token = auth_header.split(' ')[1]
      begin
        decode_token(token)
      rescue JWT::DecodeError
        nil
      end
    end

    def decode_token(token)
      JWT.decode(
        token,
        Rails.application.secrets.secret_key_base,
        true,
        algorithm: 'HS256'
      )
    end
  end
end

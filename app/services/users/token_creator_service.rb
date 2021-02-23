# frozen_string_literal: true

module Users
  class TokenCreatorService < ApplicationService
    attr_accessor :user

    def initialize(user)
      @user = user
    end

    def call
      update_user_with_jti
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    private

    def payload
      { user_id: user.id, exp: expiration, jti: user.jti }
    end

    def update_user_with_jti
      user.update_attribute(:jti, SecureRandom.uuid)
    end

    def expiration
      Time.now.to_i + 4 * 3600
    end
  end
end

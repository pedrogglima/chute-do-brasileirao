# frozen_string_literal: true

secure = if ENV['COOKIE_SECURE'].present? && ENV['COOKIE_SECURE'] == 'true'
           true
         else
           false
         end

Rails.application.config.session_store(
  :cookie_store,
  key: "_chute_do_brasileirao_#{ENV['COOKIE_ENV']}",
  expire_after: 24.hours,
  secure: secure,
  httponly: true,
  same_site: :lax
)

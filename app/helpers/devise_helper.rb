# frozen_string_literal: true

module DeviseHelper
  def provider_name(provider)
    case provider.to_s
    when 'twitter'
      'Twitter'
    when 'google_oauth2'
      'Google'
    else
      'provider não encontrado'
    end
  end
end

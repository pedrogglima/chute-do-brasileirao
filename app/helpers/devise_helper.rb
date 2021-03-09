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

  def provider_links(url, provider)
    case provider.to_s
    when 'twitter'
      twitter_link(url)
    when 'google_oauth2'
      google_link(url)
    else
      'provider não encontrado'
    end
  end

  def twitter_link(url)
    link_to url, class: 'btn btn-primary btn-block', method: :post do
      '<i class="fab fa-twitter mr-1"></i><span>Twitter</span>'.html_safe
    end
  end

  def google_link(url)
    link_to url, class: 'btn btn-block btn-google', method: :post do
      '<i class="fab fa-google mr-1"></i><span>Google</span>'.html_safe
    end
  end
end

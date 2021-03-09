# frozen_string_literal: true

# This module sets default values
#   - Tokens
#   - Global settings
module RequestSetup
  def setup_api
    before do
      # Auth
      @user = create(:user)
      token_new = Users::TokenCreatorService.call(@user)
      @token = { 'Authorization' => "Bearer #{token_new}" }

      # Global settings
      championship = create(:championship)
      @global_setting = create(:global_setting, championship: championship)
    end
    yield
  end

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def setup_omniauth
    # we set omniauth_hash here otherwise the block doesn't find it
    twitter_omniauth = omniauth_hash('twitter')
    google_omniauth = omniauth_hash('google_oauth2')

    before do
      # OAuth
      OmniAuth.config.test_mode = true
      OmniAuth.config.add_mock(:twitter, twitter_omniauth)
      OmniAuth.config.add_mock(:google_oauth2, google_omniauth)

      @auth_twitter = OmniAuth.config.mock_auth[:twitter]
      @auth_google  = OmniAuth.config.mock_auth[:google_oauth2]

      # Global settings
      championship = create(:championship)
      @global_setting = create(:global_setting, championship: championship)
    end
    yield
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def setup
    before do
      # Global settings
      championship = create(:championship)
      @global_setting = create(:global_setting, championship: championship)
    end
    yield
  end

  private

  def omniauth_hash(provider)
    {
      'provider' => provider,
      'uid' => '12345',
      'info' => {
        'name' => 'testomniauth',
        'email' => 'testomniauth@test.com'
      }
    }
  end
end

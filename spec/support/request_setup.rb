# frozen_string_literal: true

# This module sets default values
#   - Tokens
#   - Global settings
module RequestSetup
  def api_setup
    before do
      # Auth
      @user = create(:user)
      token_new = Users::TokenCreatorService.call(@user)
      @token = { "Authorization" => "Bearer #{token_new}" }

      # Global settings
      championship = create(:championship)
      @global_setting = create(:global_setting, championship: championship)
    end
    yield
  end
end

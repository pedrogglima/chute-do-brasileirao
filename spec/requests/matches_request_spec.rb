# frozen_string_literal: true
require 'rails_helper'

RSpec.describe("Matches", type: :request) do
  let(:match) { create(:match) }

  describe "GET /show" do
    it "returns http success" do
      get match_path(match)
      expect(response).to(have_http_status(:success))
    end
  end
end

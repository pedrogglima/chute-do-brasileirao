# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(Api::V1::RankingsController, type: :request) do
  describe "#index" do
    subject do
      get api_v1_rankings_path(format: :json), xhr: true
    end

    it "returns status 200" do
      subject
      expect(response).to(have_http_status(200))
    end
  end  
end

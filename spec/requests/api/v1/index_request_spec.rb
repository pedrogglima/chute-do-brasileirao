# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(Api::V1::IndexController, type: :request) do
  setup_api do
    describe "#index" do
      subject do
        get api_v1_index_path(format: :json), xhr: true
      end

      it "returns status 200" do
        subject
        expect(response).to(have_http_status(200))
      end
    end

    describe "#sidebar" do
      subject do
        get api_v1_sidebar_path(format: :json), xhr: true
      end

      it "returns status 200" do
        subject
        expect(response).to(have_http_status(200))
      end
    end
  end
end

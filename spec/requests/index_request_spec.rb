# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(IndexController, type: :request) do
  setup do
    describe "GET root" do
      it "returns http success" do
        get root_path
        expect(response).to(have_http_status(:success))
      end
    end

    describe "GET /sidebar" do
      it "returns http success" do
        get sidebar_path
        expect(response).to(have_http_status(:success))
      end
    end
  end
end

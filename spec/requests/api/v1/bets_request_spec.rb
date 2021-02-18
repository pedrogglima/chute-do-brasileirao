# frozen_string_literal: true
require 'rails_helper'

RSpec.describe("Api::v1::Bets", type: :request) do
  api_setup do
    let(:invalid_token) { { "Authorization" => "Bearer invalid token" } }
    let(:match) { create(:match, :is_today) }
    let(:bet) { build_stubbed(:bet, match: match) }

    let(:bet_params) { attributes_for(:bet) }
    let(:valid_params) do
      {
        "match_id" => match.id,
        "bet_team_score" => bet[:bet_team_score],
        "bet_opponent_score" => bet[:bet_opponent_score],
      }
    end

    let(:invalid_params) do
      {
        "match_id" => "",
        "bet_team_score" => bet[:bet_team_score],
        "bet_opponent_score" => bet[:bet_opponent_score],
      }
    end

    describe "non-loggers" do
      it "returns 401 (#index)" do
        get api_v1_bets_path(format: :json), xhr: true, headers: invalid_token
        expect(response).to(have_http_status(401))
      end

      it "returns 401 (#new)" do
        get new_api_v1_match_bet_path(match_id: match.id, format: :json), xhr: true, headers: invalid_token
        expect(response).to(have_http_status(401))
      end

      it "returns 401 (#show)" do
        get api_v1_match_bet_path(bet, match_id: match.id, format: :json), xhr: true, headers: invalid_token
        expect(response).to(have_http_status(401))
      end

      it "returns 401 (#create)" do
        post api_v1_bets_path(format: :json), xhr: true, headers: invalid_token
        expect(response).to(have_http_status(401))
      end
    end

    describe "logger users" do
      describe "#index" do
        subject do
          get api_v1_bets_path(format: :json), xhr: true, headers: @token
        end

        it "returns status 200" do
          subject
          expect(response).to(have_http_status(200))
        end
      end

      describe "#new" do
        subject do
          get new_api_v1_match_bet_path(match_id: match.id, format: :json), xhr: true, headers: @token
        end

        it "returns status 200" do
          subject
          expect(response).to(have_http_status(200))
        end
      end

      describe "#show" do
        let(:belongs_to_user) { create(:bet, user: @user, match: match) }
        let(:doesnt_belongs_to_user) { create(:bet, match: match) }

        context "if belongs to user" do
          it "returns status 200" do
            get api_v1_match_bet_path(
              belongs_to_user,
              match_id: match.id,
              format: :json
            ),
            xhr: true,
            headers: @token

            expect(response).to(have_http_status(200))
          end
        end

        context "if doesn't belongs to user" do
          it "returns status 401" do
            get api_v1_match_bet_path(
              doesnt_belongs_to_user,
              match_id: match.id,
              format: :json
            ),
            xhr: true,
            headers: @token

            expect(response).to(have_http_status(401))
          end
        end
      end

      describe "#create" do
        context "valid params" do
          subject do
            post api_v1_bets_path(params: { bet: valid_params }, format: :json), xhr: true, headers: @token
          end

          it "returns status 201" do
            subject
            expect(response).to(have_http_status(201))
          end

          it 'adds new object to db' do
            expect { subject }.to(change(Bet, :count).by(1))
          end
        end

        context "invalid params" do
          subject do
            post api_v1_bets_path(params: { bet: invalid_params }, format: :json), xhr: true, headers: @token
          end

          it "returns status 422" do
            subject
            expect(response).to(have_http_status(422))
          end

          it 'adds new object to db' do
            expect { subject }.to(change(Bet, :count).by(0))
          end
        end
      end
    end
  end
end

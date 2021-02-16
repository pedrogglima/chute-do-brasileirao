# frozen_string_literal: true
require 'rails_helper'

RSpec.describe("Bets", type: :request) do
  let(:user) { create(:user) }
  let(:bet) { create(:bet, user: user) }

  context "non-logger users" do
    it "should be redirect to (index)" do
      get bets_path
      expect(response).to(redirect_to(new_user_session_path))
      expect(request.flash_hash.alert).to(eq("Para continuar, efetue login ou registre-se."))
    end

    it "should be redirect to (new)" do
      get new_match_bet_path(bet.match.id)
      expect(response).to(redirect_to(new_user_session_path))
      expect(request.flash_hash.alert).to(eq("Para continuar, efetue login ou registre-se."))
    end

    it "should be redirect to (show)" do
      get match_bet_path(id: bet.id, match_id: bet.match.id)
      expect(response).to(redirect_to(new_user_session_path))
      expect(request.flash_hash.alert).to(eq("Para continuar, efetue login ou registre-se."))
    end

    it "should be redirect to (create)" do
      post bets_path
      expect(response).to(redirect_to(new_user_session_path))
      expect(request.flash_hash.alert).to(eq("Para continuar, efetue login ou registre-se."))
    end
  end

  context "logger users" do
    describe "GET /index" do
      it "returns http success" do
        sign_in(user)

        get bets_path
        expect(response).to(have_http_status(:success))
      end
    end

    describe "GET /new" do
      it "returns http success" do
        sign_in(user)

        get new_match_bet_path(match_id: bet.match.id)
        expect(response).to(have_http_status(:success))
      end
    end

    describe "GET /show" do
      it "returns http success" do
        sign_in(user)

        get match_bet_path(id: bet.id, match_id: bet.match.id)
        expect(response).to(have_http_status(:success))
      end
    end

    describe "POST /create" do
      let(:match) { create(:match, :not_played_yet) }

      it "when valid returns http success" do
        sign_in(user)

        bet = attributes_for(:bet)

        expect do
          post bets_path, xhr: true,
          params: {
            "bet" => {
              "match_id" => match[:id],
              "bet_team_score" => bet[:bet_team_score],
              "bet_opponent_score" => bet[:bet_opponent_score],
            },
          }
        end.to(change { Bet.count }.by(1))
        expect(response).to(have_http_status(:success))
      end

      it "when invalid returns http success" do
        sign_in(user)

        bet = attributes_for(:bet)

        expect do
          post bets_path, xhr: true,
          params: {
            "bet" => {
              "match_id" => match[:id],
              "bet_team_score" => "",
              "bet_opponent_score" => bet[:bet_opponent_score],
            },
          }
        end.to(change { Bet.count }.by(0))
        expect(response).to(have_http_status(:unprocessable_entity))
      end
    end
  end
end

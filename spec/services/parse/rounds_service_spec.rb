# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Parse::CreateOrUpdateRoundsService, type: :service) do
  let!(:global_setting) { create(:global_setting) }
  let!(:championship) { global_setting.championship }
  let!(:round) { create(:round, number: 1, championship: championship) }
  let!(:match) do
    create(
      :match, 
      round: round, 
      id_match: 1, 
      team_score: 10, 
      championship: championship
    )
  end
  let(:match_attrs) { attributes_for(:match, id_match: 2) }
  let!(:team) { create(:team) }
  let!(:opponent) { create(:team) }
  let(:updated_team_score) { 15 }
  
  let(:rounds) do
    [
      {
        "number" => round.number,
        "matches" => [
          {
            "id_match" => match.id_match,
            "number_of_changes" => match.number_of_changes,
            "place" => match.place,
            "date" => match.date,
            "team_score" => updated_team_score,
            "opponent_score" => match.opponent_score
          },
          {
            "team" => team.name,
            "id_match" => match_attrs[:id_match],
            "opponent" => opponent.name,
            "number_of_changes" => match_attrs[:number_of_changes],
            "place" => match_attrs[:place],
            "date" => match_attrs[:date],
            "team_score" => match_attrs[:team_score],
            "opponent_score" => match_attrs[:opponent_score]
          }
        ]
      }
    ]
  end

  let(:parse_resources_service) do
    Parse::CreateOrUpdateRoundsService.new(rounds)
  end
  
  describe "#call" do
    subject { parse_resources_service.call }

    # p.s let!(:resource) create outside scope of expect, resulting in 1 count
    it "should create round only if it doesn't exist" do
      expect{ parse_resources_service.call }.to(change { Round.count }.by(0))
    end

    # p.s let!(:resource) create outside scope of expect, resulting in 1 count
    it "should create match only if it doesn't exist" do
      expect{ parse_resources_service.call }.to(change { Match.count }.by(1))
    end

    it "should update if exist" do
      parse_resources_service.call 
      expect(match.reload.team_score).to(eq(updated_team_score))
    end
  end
end

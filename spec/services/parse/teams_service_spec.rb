# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Parse::CreateTeamsService, type: :service) do
  let!(:team) { create(:team) }
  let(:team_attrs) { attributes_for(:team) }
  let(:teams) do
    [
      {
        'name' => team.name,
        'state' => team.state,
        'avatar_url' => team.avatar_url
      },
      {
        'name' => team_attrs[:name],
        'state' => team_attrs[:state],
        'avatar_url' => team_attrs[:avatar_url]
      }
    ]
  end

  let(:parse_resources_service) { Parse::CreateTeamsService.new(teams) }

  describe '#call' do
    subject { parse_resources_service.call }

    # p.s let!(:resource) create outside scope of expect, resulting in 1 count
    it "should create only if it doesn't exist" do
      expect { parse_resources_service.call }.to(change { Team.count }.by(1))
    end
  end
end

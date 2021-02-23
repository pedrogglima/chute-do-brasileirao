# frozen_string_literal: true

module Parse
  class CreateTeamsService < ApplicationService
    def initialize(teams)
      @teams = teams
    end

    def call
      @teams.each do |team_hash|
        team = Team.find_by(name: team_hash['name'])
        next if team

        Team.create!(
          name: team_hash['name'],
          state: team_hash['state'],
          avatar_url: team_hash['avatar_url']
        )
      end
    end
  end
end

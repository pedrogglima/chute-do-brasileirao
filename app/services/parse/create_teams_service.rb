
# frozen_string_literal: true

module Parse
  class CreateTeamsService < ApplicationService
    def initialize(teams)
      @teams = teams
    end

    def call
      @teams.each do |t|
        team = Team.find_by(name: t["name"])
        next if team
      
        Team.create!(
          name: t["name"],
          state: t["state"],
          avatar_url: t["avatar_url"]
        )
      end
    end
  end
end

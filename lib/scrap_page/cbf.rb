# frozen_string_literal: true

require 'json'
require_relative 'utils/custom_logger'
require_relative 'cbf/models/championship'
require_relative 'cbf/models/teams'
require_relative 'cbf/models/rankings'
require_relative 'cbf/models/rounds'

# Scrap the https://www.cbf.com.br/ page.
# Right know it scraps the table (standing) and round matches.
#
module ScrapPage
  class CBF
    include Utils::CustomLogger

    LOG_PATH = "#{File.dirname(__FILE__)}/cbf/logs"

    attr_reader :championship,
                :teams,
                :rankings,
                :rounds

    def initialize(document)
      @logger = initialize_logger("#{LOG_PATH}/main.log")

      @championship = ScrapPage::CBF::Models::Championship.new(document)

      @scrap_teams = ScrapPage::CBF::Models::Teams.new(document)
      @scrap_rounds = ScrapPage::CBF::Models::Rounds.new(document)
      @scrap_rankings = ScrapPage::CBF::Models::Rankings.new(document)

      @teams = @scrap_teams.teams
      @rounds = @scrap_rounds.rounds
      @rankings = @scrap_rankings
    end

    def to_json(*_args)
      {
        championship: @championship.to_h,
        teams: @scrap_teams.to_h,
        rounds: @scrap_rounds.to_h,
        rankings: @scrap_rankings.to_h

      }.to_json
    end

    def to_h
      {
        championship: @championship.to_h,
        teams: @scrap_teams.to_h,
        rounds: @scrap_rounds.to_h,
        rankings: @scrap_rankings.to_h

      }
    end
  end
end

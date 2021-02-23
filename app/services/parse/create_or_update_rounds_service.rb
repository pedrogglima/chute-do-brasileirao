# frozen_string_literal: true

module Parse
  class CreateOrUpdateRoundsService < ApplicationService
    def initialize(rounds)
      @rounds = rounds
    end

    def call
      @rounds.each do |round_hash|
        round = find_or_create_round(round_hash)

        create_or_update_matches(round, round_hash)
      end
    end

    private

    def find_or_create_round(round_hash)
      round = find_round(round_hash['number'])
      round || create_round(round_hash)
    end

    def find_round(number)
      Round.where(
        number: number.to_i,
        championship_id: current_championship.id
      ).first
    end

    def create_round(round)
      Round.create!(
        championship_id: current_championship.id,
        number: round['number'].to_i
      )
    end

    def create_or_update_matches(round, round_hash)
      round_hash['matches'].each do |match_hash|
        match = find_match(match_hash['id_match'])

        if match
          update_match(match, match_hash)
        else
          team = find_team(match_hash['team'])
          opponent = find_team(match_hash['opponent'])

          create_match(match_hash, round.id, team.id, opponent.id)
        end
      end
    end

    def find_match(id_match)
      Match.where(
        id_match: id_match,
        championship_id: current_championship.id
      ).first
    end

    def update_match(match, match_hash)
      match.update!(
        number_of_changes: match_hash['number_of_changes'],
        place: match_hash['place'],
        date: to_datetime(match_hash['date']),
        team_score: match_hash['team_score'],
        opponent_score: match_hash['opponent_score']
      )
    end

    # rubocop:disable Metrics/MethodLength
    def create_match(match_hash, round_id, team_id, opponent_id)
      Match.create!(
        championship_id: current_championship.id,
        round_id: round_id,
        team_id: team_id,
        id_match: match_hash['id_match'],
        opponent_id: opponent_id,
        number_of_changes: match_hash['number_of_changes'],
        place: match_hash['place'],
        date: to_datetime(match_hash['date']),
        team_score: match_hash['team_score'],
        opponent_score: match_hash['opponent_score']
      )
    end
    # rubocop:enable Metrics/MethodLength

    def find_team(name)
      Team.find_by(name: name)
    end

    def to_datetime(string)
      string&.to_datetime
    end

    def current_championship
      GlobalSetting.singleton.championship
    end
  end
end

module Parse
  class CreateOrUpdateRoundsService < ApplicationService
    def initialize(rounds)
      @rounds = rounds
    end

    def call
      championship = GlobalSetting.singleton.championship

      @rounds.each do |r|
        round = Round.where(
          number: r["number"].to_i,
          championship_id: championship.id
        ).first  

        round = create_round(r, championship.id) unless round

        # each round has n numbers of matches
        create_matches(round, r, championship.id)
      end
    end

    private

    def create_round(round, champ_id)
      Round.create!(
        championship_id: champ_id,
        number: round["number"].to_i
      )
    end

    def create_matches(obj_round, round, champ_id)
      round["matches"].each do |m|
        match = Match.where(
          id_match: m["id_match"],
          championship_id: champ_id
        ).first

        if match
          update_match(match, m)
        else
          create_match(m, champ_id, obj_round.id)
        end
      end
    end
    
    def update_match(obj, match)
      obj.update!(
        number_of_changes: match["number_of_changes"],
        place: match["place"],
        date: to_datetime(match["date"]),
        team_score: match["team_score"],
        opponent_score: match["opponent_score"]
      )
    end

    def create_match(match, champ_id, round_id)
      team = Team.find_by(name: match["team"])
      opponent = Team.find_by(name: match["opponent"])

      Match.create!(
        championship_id: champ_id,
        round_id: round_id,
        team_id: team.id,
        id_match: match["id_match"],
        opponent_id: opponent.id,
        number_of_changes: match["number_of_changes"],
        place: match["place"],
        date: to_datetime(match["date"]),
        team_score: match["team_score"],
        opponent_score: match["opponent_score"]
      )
    end

    def to_datetime(string)
      string.to_datetime if string
    end
  end
end

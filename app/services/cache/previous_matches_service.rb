# frozen_string_literal: true

module Cache
  class PreviousMatchesService < Cache::Base::ListService
    KEY = 'previous_matches_list'
    EXP = 3600

    def call
      res = list(KEY, FROM, TO)

      return res unless res.empty?

      load_resources(KEY, EXP)
      list(KEY, FROM, TO)
    end

    protected

    def resources
      Match.team_with_avatar
           .opponent_with_avatar
           .previous_matches(Date.yesterday.end_of_day)
           .where(championship_id: @params[:current_championship_id])
           .order(date: :desc)
    end

    def to_json(match)
      hash_resource(match).to_json
    end

    private

    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/AbcSize
    def hash_resource(match)
      {
        id: match.id,
        date: match.date,
        id_match: match.id_match,
        team_avatar: extract_url(match.team.avatar),
        team_name: match.team.name,
        team_score: match.team_score,
        opponent_avatar: extract_url(match.opponent.avatar),
        opponent_name: match.opponent.name,
        opponent_score: match.opponent_score,
        place: match.place
      }
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength
  end
end

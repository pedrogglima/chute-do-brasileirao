# frozen_string_literal: true

module Cache
  class NextMatchesService < Cache::Base::ListService
    KEY = 'next_matches_list'

    def call
      res = list(KEY, FROM, TO)

      return res unless res.empty?

      load_objects(KEY)
      list(KEY, FROM, TO)
    end

    protected

    def resources
      Match.team_with_avatar
           .opponent_with_avatar
           .next_matches(Date.tomorrow.midnight)
           .where(championship_id: @params[:current_championship_id])
           .order(date: :asc)
    end

    def to_json(match)
      {
        id: match.id,
        date: match.date,
        id_match: match.id_match,
        team_avatar: extract_url(match.team.avatar),
        team_name: match.team.name,
        opponent_avatar: extract_url(match.opponent.avatar),
        opponent_name: match.opponent.name,
        place: match.place
      }.to_json
    end
  end
end

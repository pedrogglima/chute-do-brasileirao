# frozen_string_literal: true

module Cache
  class TodayMatchesService < Cache::Base::ListService
    KEY = 'today_matches_list'

    def call
      res = list(KEY, FROM, TO)

      return res unless res.empty?

      load_resources(KEY)
      list(KEY, FROM, TO)
    end

    protected

    def resources
      Match.team_with_avatar
           .opponent_with_avatar
           .where(date: 1.day.ago..2.days.from_now)
           .where(championship_id: @params[:current_championship_id])
           .order(date: :asc)
    end

    def to_json(match)
      hash_resource(match).to_json
    end

    private

    # rubocop:disable Metrics/MethodLength
    def hash_resource(match)
      {
        id: match.id,
        date: match.date,
        id_match: match.id_match,
        team_avatar: extract_url(match.team.avatar),
        team_name: match.team.name,
        opponent_avatar: extract_url(match.opponent.avatar),
        opponent_name: match.opponent.name,
        place: match.place,
        update_at: match.updated_at
      }
    end
    # rubocop:enable Metrics/MethodLength
  end
end

# frozen_string_literal: true

ScrapCbfRecord.settings do |config|
  log_path = Rails.root.join('log', 'scrap_cbf_record.log')

  config.logger = Logger.new(log_path)

  config.championship.config = {
    class_name: 'Championship',
    rename_attrs: {},
    exclude_attrs_on_create: %i[serie],
    exclude_attrs_on_update: %i[serie],
    associations: {}
  }

  config.match.config = {
    class_name: 'Match',
    rename_attrs: {},
    exclude_attrs_on_create: %i[serie],
    exclude_attrs_on_update: %i[serie],
    associations: {
      championship: {
        class_name: 'Championship',
        foreign_key: :championship_id
      },
      round: {
        class_name: 'Round',
        foreign_key: :round_id
      },
      team: {
        class_name: 'Team',
        foreign_key: :team_id
      },
      opponent: {
        class_name: 'Team',
        foreign_key: :opponent_id
      }
    }
  }

  config.ranking.config = {
    class_name: 'Ranking',
    rename_attrs: {},
    exclude_attrs_on_create: %i[serie],
    exclude_attrs_on_update: %i[serie],
    associations: {
      championship: {
        class_name: 'Championship',
        foreign_key: :championship_id
      },
      team: {
        class_name: 'Team',
        foreign_key: :team_id
      },
      next_opponent: {
        class_name: 'Team',
        foreign_key: :next_opponent_id
      }
    }
  }

  config.round.config = {
    class_name: 'Round',
    rename_attrs: {},
    exclude_attrs_on_create: %i[serie],
    exclude_attrs_on_update: %i[serie],
    associations: {
      championship: {
        class_name: 'Championship',
        foreign_key: :championship_id
      }
    }
  }

  config.team.config = {
    class_name: 'Team',
    rename_attrs: {},
    exclude_attrs_on_create: %i[],
    exclude_attrs_on_update: %i[],
    associations: {}
  }
end

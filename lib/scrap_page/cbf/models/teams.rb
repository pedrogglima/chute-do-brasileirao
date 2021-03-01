# frozen_string_literal: true

require_relative '../../utils/findable'

module ScrapPage
  class CBF
    module Models
      # This class scrap a table. It does it by searching for the first table
      #  that matches a array of strings. After found, it scraps the rows.
      # Public methods are:
      #   :teams: returns [] of Team
      class Teams
        class Team
          attr_accessor :name,
                        :state,
                        :avatar_url

          def to_h
            {
              name: name,
              state: state,
              avatar_url: avatar_url
            }
          end
        end

        include ScrapPage::Utils::Findable

        attr_accessor :teams

        # @params document [Nokogiri::XML::Document]
        def initialize(document)
          tables = document.css('table')
          @table = find_table_by_header(
            tables,
            %w[Posição PTS J V E D GP GC SG CA CV % Recentes Próx].freeze
          )

          @teams = []

          scrap_teams if @table
        end

        # returns [] of hash<team>
        def to_h
          array_teams = []
          teams.each do |team|
            array_teams << team.to_h
          end

          array_teams
        end

        def scrap_teams
          tbody = @table.css('tbody').first
          return unless tbody

          tbody.css('tr').each do |tr|
            # Remove the rows that are invisible by default
            next if tr.element? && tr['style']&.eql?('display: none')

            # teams are extract from <img>
            teams = tr.css('img')
            # Two teams found on a row
            if teams.length >= 1 && teams.length <= 2
              # Only the first team is needed
              elem_team = teams.first
              scrap_team(elem_team)
            else
              raise "wrong number of teams founded: #{teams.length}"
            end
          end
        end

        def scrap_team(elem)
          if elem&.key?('title') &&
             elem['title'].match?(/^[a-záàâãéèêíïóôõöúç\s]+ - [a-z]{2}$/i)

            team = Team.new

            # Extract team's name (e.g Santos - SP => Santos)
            team.name = elem['title'][/^[a-záàâãéèêíïóôõöúç\s]{3,50}/i].strip
            # Extract team's states (e.g Santos - SP => SP)
            team.state = elem['title'][/[a-z]{2}$/i]
            # Extract team's avatar_url url
            team.avatar_url = elem['src'] if elem.key?('src')

            @teams << team
          end
        end
      end
    end
  end
end

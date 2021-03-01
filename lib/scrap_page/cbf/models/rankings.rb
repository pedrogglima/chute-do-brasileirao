# frozen_string_literal: true

require_relative '../../utils/findable'

module ScrapPage
  class CBF
    module Models
      # This class scrap a table. It does it by searching for the first table
      #  that matches a array of strings. After found, it scrap the header & rows.
      # Public methods are:
      #   :rankings: returns [] of type Ranking
      class Rankings
        class HeaderColumn
          attr_reader :value, :title
          def initialize(value, title)
            @value = value
            @title = title || nil
          end
        end

        class Row
          attr_reader :cells
          def initialize
            @cells = []
          end
        end

        class Cell
          attr_reader :value, :team
          def initialize(value, team)
            @value = value
            @team  = team || nil
          end
        end

        class Ranking
          attr_accessor :posicao,
                        :team,
                        :pontos,
                        :jogos,
                        :vitorias,
                        :empates,
                        :derrotas,
                        :gols_pro,
                        :gols_contra,
                        :saldo_de_gols,
                        :cartoes_amarelos,
                        :cartoes_vermelhos,
                        :aproveitamento,
                        :recentes,
                        :next_opponent
        end

        include ScrapPage::Utils::Findable

        attr_accessor :rankings

        # @params document [Nokogiri::XML::Document]
        def initialize(document)
          tables = document.css('table')
          @table = find_table_by_header(
            tables,
            %w[Posição PTS J V E D GP GC SG CA CV % Recentes Próx].freeze
          )

          @header = []
          @rows   = []
          @rankings = []

          if @table
            scrap_header
            scrap_body
            populate_rankings
          end
        end

        # returns [] of hash<ranking>
        def to_h
          array_rankings = []

          rankings.each do |ranking|
            array_rankings << {
              posicao: ranking.posicao,
              team: ranking.team,
              pontos: ranking.pontos,
              jogos: ranking.jogos,
              vitorias: ranking.vitorias,
              empates: ranking.empates,
              derrotas: ranking.derrotas,
              gols_pro: ranking.gols_pro,
              gols_contra: ranking.gols_contra,
              saldo_de_gols: ranking.saldo_de_gols,
              cartoes_amarelos: ranking.cartoes_amarelos,
              cartoes_vermelhos: ranking.cartoes_vermelhos,
              aproveitamento: ranking.aproveitamento,
              recentes: ranking.recentes,
              next_opponent: ranking.next_opponent
            }
          end

          array_rankings
        end

        private

        def populate_rankings
          @rows.each do |row|
            ranking = Ranking.new

            row.cells.each_with_index do |cell, idx|
              case idx
              when 0
                ranking.posicao = cell.value
                ranking.team = cell.team
              when 1
                ranking.pontos = cell.value
              when 2
                ranking.jogos = cell.value
              when 3
                ranking.vitorias = cell.value
              when 4
                ranking.empates = cell.value
              when 5
                ranking.derrotas = cell.value
              when 6
                ranking.gols_pro = cell.value
              when 7
                ranking.gols_contra = cell.value
              when 8
                ranking.saldo_de_gols = cell.value
              when 9
                ranking.cartoes_amarelos = cell.value
              when 10
                ranking.cartoes_vermelhos = cell.value
              when 11
                ranking.aproveitamento = cell.value
              when 12
                ranking.recentes = cell.value
              when 13
                ranking.next_opponent = cell.team
              end
            end

            @rankings << ranking
          end
        end

        def scrap_header
          # only single level header
          thead = @table.css('thead').first
          return unless thead

          thead.css('tr > th').each do |th|
            text = th.element? && th.text.gsub(/\s+/, '')
            next unless text && !text.empty?

            child = th.children.find { |elem| elem.element? && elem['title'] }
            title = child['title'] if child

            @header << HeaderColumn.new(text, title)
          end
        end

        def scrap_body
          tbody = @table.css('tbody').first
          return unless tbody

          tbody.css('tr').each do |tr|
            # Remove the rows that are invisible by default
            next if tr.element? && tr['style']&.eql?('display: none')

            row = Row.new
            tr.children.each do |td|
              text = td.element? && td.text.gsub(/\s+/, '')

              next unless text

              # Gets position (e.g 7º 0 Fluminense-RJ => 7º)
              text = text[/^\d{1,2}º/i].strip if text&.match?(/^\d{1,2}º/i)

              # Gets title if exist
              child = td.children.find { |elem| elem.element? && elem['title'] }
              title = child['title'] if child

              # Extract team's name (e.g Santos - SP => Santos)
              if title&.match?(/^[a-záàâãéèêíïóôõöúç\s\-]+ - [a-z]{2}$/i)
                team = title[/^[a-záàâãéèêíïóôõöúç\s]{3,50}/i].strip
              end

              row.cells << Cell.new(text, team)
            end

            if row.cells.length == @header.length
              @rows << row
            else
              raise 'error - header length not compatible with rows size'
            end
          end
        end
      end
    end
  end
end

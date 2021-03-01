# frozen_string_literal: true

module ScrapPage
  class CBF
    module Models
      # This class scrap <h2>.
      # Public methods are:
      #   :year: <string>
      #   :division: <string>
      class Championship
        attr_accessor :year, :division

        # @params document [Nokogiri::XML::Document]
        def initialize(document)
          @headers = document.css('h2')

          @year = nil
          @division = nil

          scrap_header
        end

        def to_h
          {
            year: year,
            division: division
          }
        end

        private

        def scrap_header
          @headers.each do |h|
            next unless h.text.match?(
              /CAMPEONATO BRASILEIRO DE FUTEBOL [a-záàâãéèêíïóôõöúç\s\-]+ \d{4}$/i
            )

            self.year = h.text[/\d{4}$/i]
            self.division = 'Série A'
          end
        end
      end
    end
  end
end

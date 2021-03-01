# frozen_string_literal: true

module ScrapPage
  module Utils
    module Findable
      # Find in the Document the first table with single header and level that
      #  matches with input compare. The % match must be >= than accuracy.
      #
      # @return [Nokogiri::XML::Element, nil]
      def find_table_by_header(
        elems,
        compare,
        regex = '[[:alpha:]]+',
        accuracy = 1.0
      )
        elems.find do |table|
          # check only single level header
          thead = table.css('thead').first
          return false if !thead || thead.css('tr').length > 1

          header = thead.text.scan(Regexp.new(regex))

          return false if header.empty?

          matches = (compare & header).length
          header.length / matches >= accuracy
        end
      end
    end
  end
end

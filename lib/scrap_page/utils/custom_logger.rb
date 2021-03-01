# frozen_string_literal: true

require 'active_support/logger'

module ScrapPage
  module Utils
    module CustomLogger
      def initialize_logger(file_path)
        Logger.new(
          file_path,
          datetime_format: '%d-%m-%Y %H:%M:%S'
        )
      end
    end
  end
end

# frozen_string_literal: true

require 'active_support/core_ext/object/blank'

module CoreExtensions
  module String
    module CustomModifiers
      # replace chars using brazilian's accents with same chars without the accent
      #
      def remove_br_accents
        tr(
          'ÄÅÁÂÀÃäáâàãÉÊËÈéêëèÍÎÏÌíîïìÖÓÔÒÕöóôòõÜÚÛüúûùÇç',
          'AAAAAAaaaaaEEEEeeeeIIIIiiiiOOOOOoooooUUUuuuuCc'
        )
      end

      # format string to comman syntax used for writing filenames
      #
      def fileable
        tr(' ', '_').downcase
      end
    end
  end
end

String.include CoreExtensions::String::CustomModifiers

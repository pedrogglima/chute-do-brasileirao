# frozen_string_literal: true

class CustomLogFormatter
  def initialize
    # Suppress is an array of request uuids. Each listed uuid means no messages from this request.
    @suppress = []
  end

  def call(_severity, _datetime, _progname, message)
    # Get uuid, which we need to properly distinguish between parallel requests.
    # Also remove uuid information from log (that's why we match the rest of message)
    matches = /\[([0-9a-zA-Z\-_]+)\] (.*)/m.match(message)

    if matches
      uuid = matches[1]
      message = matches[2]

      if @suppress.include?(uuid) && message.start_with?('Completed ')
        # Each request in Rails log ends with "Completed ..." message, so do suppressed messages.
        @suppress.delete(uuid)
        nil

      elsif message.start_with?('Processing by ActiveStorage::DiskController#show', 'Processing by ActiveStorage::BlobsController#show', 'Processing by ActiveStorage::RepresentationsController#show', 'Started GET "/rails/active_storage/disk/', 'Started GET "/rails/active_storage/blobs/', 'Started GET "/rails/active_storage/representations/')
        # When we use ActiveStorage disk provider, there are three types of request: Disk requests, Blobs requests and Representation requests.
        # These three types we would like to hide.
        @suppress << uuid
        nil

      elsif !@suppress.include?(uuid)
        # All messages, which are not suppressed, print. New line must be added here.
        "#{message}\n"
      end

    else
      # Return message as it is (including new line at the end)
      "#{message}\n"
    end
  end
end

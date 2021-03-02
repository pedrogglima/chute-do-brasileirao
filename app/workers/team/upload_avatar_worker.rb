# frozen_string_literal: true

require 'open-uri'

class Team
  class UploadAvatarWorker < ApplicationWorker
    sidekiq_options queue: 'default'

    def perform(id)
      team = Team.find(id)
      url = URI.parse(team.avatar_url)

      team.avatar.attach(
        io: url.open,
        filename: "avatar_#{team.name}".downcase,
        content_type: 'image/jpg'
      )
    end
  end
end

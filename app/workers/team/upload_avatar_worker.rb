# frozen_string_literal: true
class Team
  class UploadAvatarWorker < ApplicationWorker
    sidekiq_options queue: 'default'

    def perform(id)
      team = Team.find(id)
      url = URI.parse(team.avatar_url)

      team.avatar.attach(
        io: url.open,
        filename: "avatar_#{team.name}",
        content_type: 'image/jpg'
      )
    end
  end
end

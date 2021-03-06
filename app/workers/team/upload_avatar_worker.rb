# frozen_string_literal: true

class Team
  class UploadAvatarWorker < ApplicationWorker
    sidekiq_options queue: 'default'

    def perform(id)
      Team.find(id).upload_avatar_from_url
    end
  end
end

# frozen_string_literal: true

class BaseCaches
  include Rails.application.routes.url_helpers
  attr_reader :key

  protected

  def to_json(*_args)
    raise 'this method should be overriden'
  end

  # generate urls for Active Storage associations
  def extract_url(resource)
    rails_blob_path(resource, disposition: 'attachment', only_path: true)
  end

  private

  def redis
    Redis.current
  end
end

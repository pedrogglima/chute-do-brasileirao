# frozen_string_literal: true

class BaseCaches
  include Rails.application.routes.url_helpers

  protected

  def to_json(*_args)
    raise 'this method should be overriden'
  end

  # generate urls for Active Storage associations
  def extract_blob_url(resource)
    rails_blob_url(resource, disposition: 'attachment', only_path: true)
  end

  def extract_variant_url(resource)
    rails_representation_url(
      resource,
      disposition: 'attachment',
      only_path: true
    )
  end

  private

  def redis
    Redis.current
  end
end

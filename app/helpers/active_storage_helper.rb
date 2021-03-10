# frozen_string_literal: true

module ActiveStorageHelper
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
end

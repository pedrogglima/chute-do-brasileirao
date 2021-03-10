# frozen_string_literal: true

module CachesHelper
  def render_from_partials_cache(resources)
    resources.join('').html_safe
  end
end

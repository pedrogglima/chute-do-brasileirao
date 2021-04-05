# frozen_string_literal: true

# Base class for classes that encapsulate Redis logic for caching
#
class BaseCache
  protected

  def stringify_partial(resource, partial, partial_resource_as)
    ApplicationController.renderer.render(
      partial: partial,
      locals: { "#{partial_resource_as}": resource }
    )
  end

  private

  def redis
    Redis.current
  end
end

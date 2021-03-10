# frozen_string_literal: true

class BaseCaches
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

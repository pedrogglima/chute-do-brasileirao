# frozen_string_literal: true

# @abstract Subclass is expected to implement #cache
#
module ListCacheable
  extend Forwardable

  def_delegators :cache, :get, :set, :set_reverse, :del
end

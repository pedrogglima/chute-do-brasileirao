# frozen_string_literal: true

module Cache
  module Base
    class ListService < ApplicationService
      include Rails.application.routes.url_helpers
      KEY = 'list'
      FROM = 0
      TO = -1

      def initialize(params)
        @params = params
      end

      def call
        res = list(KEY, FROM, TO)

        return res unless res.empty?

        load_resources(KEY)
        list(KEY, FROM, TO)
      end

      protected

      def list(key, from, to)
        redis.lrange(key, from, to).map do |raw_resource|
          JSON.parse(raw_resource).with_indifferent_access
        end
      end

      def load_resources(key)
        resources.each do |resource|
          redis.rpush(key, to_json(resource))
        end
      end

      def resources
        raise 'this method should be overriden'
      end

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
  end
end

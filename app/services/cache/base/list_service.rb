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

        load_objects(KEY)
        list(KEY, FROM, TO)
      end
      
      def list(key, from, to)
        $redis.lrange(key, from, to).map do |raw_resource|
          JSON.parse(raw_resource).with_indifferent_access
        end
      end
      
      def load_objects(key)
        resources.each do |resource|
          $redis.rpush(KEY, to_json(resource))
        end
      end

      def resources
        raise 'this method should be overriden'
      end

      def to_json
        raise 'this method should be overriden'
      end
      
      def extract_url(resource)
        rails_blob_path(resource, disposition: 'attachment', only_path: true)
      end
    end
  end
end
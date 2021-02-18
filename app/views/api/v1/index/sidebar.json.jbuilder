# frozen_string_literal: true
json.data do
  json.top_rankings do
    json.array!(@top_rankings) do |top_ranking|
      json.top_ranking do
        json.partial!('api/v1/index/partials/ranking', ranking: top_ranking)
      end
    end
  end

  json.bottom_rankings do
    json.array!(@bottom_rankings) do |bottom_ranking|
      json.bottom_ranking do
        json.partial!('api/v1/index/partials/ranking', ranking: bottom_ranking)
      end
    end
  end
end

# frozen_string_literal: true
json.data do
  json.today_matches do
    json.array!(@today_matches) do |today_match|
      json.today_match do
        json.partial!('api/v1/matches/partials/match', match: today_match)
      end
    end
  end

  json.next_matches do
    json.array!(@next_matches) do |next_match|
      json.next_match do
        json.partial!('api/v1/matches/partials/match', match: next_match)
      end
    end
  end

  json.previous_matches do
    json.array!(@previous_matches) do |previous_match|
      json.previous_match do
        json.partial!('api/v1/matches/partials/match', match: previous_match)
      end
    end
  end
end

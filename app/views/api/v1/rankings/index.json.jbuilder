# frozen_string_literal: true
json.data do
  json.championship do
    json.partial!(
      'api/v1/championships/partials/championship',
      championship: @current_championship
    )
  end

  json.rankings do
    json.array!(@rankings) do |ranking|
      json.ranking do
        json.partial!('api/v1/rankings/partials/ranking', ranking: ranking)
      end
    end
  end
end

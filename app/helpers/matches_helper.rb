# frozen_string_literal: true
module MatchesHelper
  def format_time(time)
    time&.strftime("%Hh%M")
  end

  def format_datetime(datetime)
    I18n.l(datetime, format: "%a, %d/%m/%Y - %Hh%M") if datetime
  end

  def format_score(team_score, opponent_score)
    if team_score && opponent_score
      "#{team_score} x #{opponent_score}"
    end
  end

  def has_score?(team_score, opponent_score)
    team_score && opponent_score ? true : false
  end

  def format_id_match(id)
    "Jogo: #{id}" if id
  end
end

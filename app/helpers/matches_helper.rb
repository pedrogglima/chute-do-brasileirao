# frozen_string_literal: true
module MatchesHelper
  def format_time(time)
    time&.strftime("%Hh%M")
  end

  def format_date(date)
    I18n.l(date, format: "%a, %d/%m/%Y") if date
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

  def style_number_of_goals(score)
    if score
      if score >= 1
        "<span class=\"badge badge-success\">#{score}</span>".html_safe
      else
        "<span class=\"badge badge-secondary\">#{score}</span>".html_safe
      end
    else
      "<span class=\"badge badge-info\">Aguardando resultado</span>".html_safe
    end
  end
end

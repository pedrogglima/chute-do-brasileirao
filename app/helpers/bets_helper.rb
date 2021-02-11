# frozen_string_literal: true
module BetsHelper
  def format_bet_score(bet_team_score, bet_opponent_score)
    if bet_team_score && bet_opponent_score
      "#{bet_team_score} x #{bet_opponent_score}"
    end
  end

  def style_bet_number_of_goals(bet, score)
    if score
      if bet == score
        "<span class=\"badge badge-success\">#{bet}</span>".html_safe
      else
        "<span class=\"badge badge-danger\">#{bet}</span>".html_safe
      end
    else
      "<span class=\"badge badge-secondary\">#{bet}</span>".html_safe
    end
  end

  def display_result(match)
    if has_score?(match.team_score, match.opponent_score)
      "Resultado: #{match.team_score} x #{match.opponent_score}"
    else
      "Resultado: Aguardando"
    end
  end

  def select_message(bet, match)
    if win_bet?(bet, match)
      "<span class=\"badge badge-success\">#{win_messages}".html_safe
    elsif almost_win_bet?(bet, match)
      "<span class=\"badge badge-info\">#{almost_win_messages}".html_safe
    else
      "<span class=\"badge badge-secondary\">#{lost_messages}".html_safe
    end
  end

  def win_messages
    [
      "Acertou na mosca!",
      "Que chutasso!",
      "Tu é bom de chute!",
      "Tá dentro!",
      "Gooool!",
    ].sample
  end

  def almost_win_messages
    [
      "Quaaasee!",
      "Na trave!",
      "No travessão!",
      "Essa foi por pouco!",
    ].sample
  end

  def lost_messages
    [
      "Ihh, passou longe!",
      "Essa nem passou pertou!",
      "Ihh, essa não deu!",
      "Chutou longe!",
    ].sample
  end

  def win_bet?(bet, match)
    if bet.bet_team_score == match.team_score &&
    bet.bet_opponent_score == match.opponent_score
      true
    else
      false
    end
  end

  # Return true for bets diffing by one for the betted team from score for the correct team
  # e.g bet: 1x0 & score: 0x0 => true
  #     bet: 2x1 & score: 1x1 => true
  #     bet: 0x1 & score: 1x0 => false
  def almost_win_bet?(bet, match)
    if diff_by_one?(bet.bet_team_score, match.team_score) &&
      bet.bet_opponent_score == match.opponent_score ||
      diff_by_one?(bet.bet_opponent_score, match.opponent_score) &&
      bet.bet_team_score == match.team_score
      true
    else
      false
    end
  end

  def diff_by_one?(v1, v2)
    (v1 - v2).abs == 1 ? true : false
  end
end

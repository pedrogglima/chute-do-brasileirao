# frozen_string_literal: true

module RankingsHelper
  def style_posicao(posicao)
    case posicao
    when 1..6
      span("#{posicao}º", 'badge badge-success')
    when 6..16
      span("#{posicao}º", 'badge badge-secondary')
    when 17..20
      span("#{posicao}º", 'badge badge-danger')
    else
      "#{posicao}º"
    end
  end

  def style_recentes(string)
    output = ''
    string.each_char do |char|
      res = select_span(char)
      output += res
    end
    output.html_safe
  end

  private

  def span(text, klass)
    content_tag :span, class: klass do
      text
    end
  end

  def select_span(char)
    case char
    when 'D'
      span(char, 'badge badge-danger')
    when 'E'
      span(char, 'badge badge-secondary')
    when 'V'
      span(char, 'badge badge-success')
    else
      span(char, 'badge badge-secondary')
    end
  end
end

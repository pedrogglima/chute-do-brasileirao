# frozen_string_literal: true
module RankingsHelper
  def style_posicao(posicao)
    case posicao
    when 1..6
      content_tag :span, class: "badge badge-success" do
        "#{posicao}º"
      end
    when 6..16
      content_tag :span, class: "badge badge-secondary" do
        "#{posicao}º"
      end
    when 17..20
      content_tag :span, class: "badge badge-danger" do
        "#{posicao}º"
      end
    else
      "#{posicao}º"
    end
  end

  def style_recentes(string)
    output = ""
    string.each_char do |char|
      res = case char
      when "D"
        content_tag :span, class: "badge badge-danger" do
          "D"
        end
      when "E"
        content_tag :span, class: "badge badge-secondary" do
          "E"
        end
      when "V"
        content_tag :span, class: "badge badge-success" do
          "V"
        end
      else
        content_tag :span, class: "badge badge-secondary" do
          char
        end
      end
      output += res
    end
    output.html_safe
  end
end

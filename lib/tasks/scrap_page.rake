# frozen_string_literal: true

namespace :scrap_page do
  namespace :cbf do
    # TODO: add this url to GlobalSetting model
    url = 'https://www.cbf.com.br/futebol-brasileiro/competicoes/campeonato-brasileiro-serie-a/2020'

    # :environment load the dependencies Nokogiri, Open-uri and ScrapPage
    task print: :environment do
      document = Nokogiri::HTML(URI.open(url))
      cbf = ScrapPage::CBF.new(document)

      puts '------------ CBF PRINTED PAGE IN JSON ---------------'
      puts cbf.to_json
      puts '-----------------------------------------------------'
    end
  end
end

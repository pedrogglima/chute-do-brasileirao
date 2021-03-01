# frozen_string_literal: true

namespace :scrap_page do
  namespace :cbf do
    # :environment load the dependencies Nokogiri, Open-uri and ScrapPage
    task print: :environment do
      url = GlobalSetting.singleton.cbf_url

      document = Nokogiri::HTML(URI.open(url))
      cbf = ScrapPage::CBF.new(document)

      puts '------------ CBF PRINTED PAGE IN JSON ---------------'
      puts cbf.to_json
      puts '-----------------------------------------------------'
    end
  end
end

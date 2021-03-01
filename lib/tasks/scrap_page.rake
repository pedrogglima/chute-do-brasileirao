# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
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

    # update the app with new data extract from the GlobalSetting.cbf_url
    task update: :environment do
      url = GlobalSetting.singleton.cbf_url

      document = Nokogiri::HTML(URI.open(url))
      cbf = ScrapPage::CBF.new(document)

      readable_format = JSON.parse(cbf.to_json)

      Parse::CreateTeamsService.call(readable_format['teams'])
      Parse::CreateOrUpdateRankingsService.call(readable_format['rankings'])
      Parse::CreateOrUpdateRoundsService.call(readable_format['rounds'])
    end

    # update the app with data extract from sample
    namespace :update do
      task sample: :environment do
        path_to_sample = Rails.root.join(
          'lib',
          'scrap_page',
          'cbf',
          'sample',
          'campeonato_brasileirao_2020.html'
        )

        document = Nokogiri::HTML(URI.open(path_to_sample))
        cbf = ScrapPage::CBF.new(document)

        readable_format = JSON.parse(cbf.to_json)

        Parse::CreateTeamsService.call(readable_format['teams'])
        Parse::CreateOrUpdateRankingsService.call(readable_format['rankings'])
        Parse::CreateOrUpdateRoundsService.call(readable_format['rounds'])
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength

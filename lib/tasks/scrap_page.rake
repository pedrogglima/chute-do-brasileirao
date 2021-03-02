# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
namespace :scrap_page do
  namespace :cbf do
    # :environment load the dependencies Nokogiri, Open-uri and ScrapPage
    task print: :environment do
      url = GlobalSetting.singleton.cbf_url

      cbf = ScrapPage::CBF.new(url)

      puts '------------ CBF PRINTED PAGE IN JSON ---------------'
      puts cbf.to_json
      puts '-----------------------------------------------------'
    end

    # update the app with new data extract from the GlobalSetting.cbf_url
    task update: :environment do
      url = GlobalSetting.singleton.current_championship_url

      cbf = ScrapPage::CBF.new(url).readable_format

      Parse::CreateTeamsService.call(cbf['teams'])
      Parse::CreateOrUpdateRankingsService.call(cbf['rankings'])
      Parse::CreateOrUpdateRoundsService.call(cbf['rounds'])
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

        cbf = ScrapPage::CBF.new(path_to_sample).readable_format

        Parse::CreateTeamsService.call(cbf['teams'])
        Parse::CreateOrUpdateRankingsService.call(cbf['rankings'])
        Parse::CreateOrUpdateRoundsService.call(cbf['rounds'])
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength

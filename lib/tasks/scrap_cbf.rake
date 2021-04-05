# frozen_string_literal: true

require 'scrap_cbf'
require 'scrap_cbf_record'

namespace :scrap_cbf do
  namespace :config do
    task validate!: :environment do
      ScrapCbfRecord::Config.instance.validate!
    end
  end

  task :print do
    cbf = ScrapCbf.new({ year: 2021 })

    p '------------ CBF PRINTED PAGE IN JSON ---------------'
    cbf.print
    p '-----------------------------------------------------'
  end

  task update: :environment do
    cbf = ScrapCbf.new({ year: 2021 })

    ScrapCbfRecord::ActiveRecord.save(cbf.to_h)
  end

  # update the app with data extract from sample
  namespace :update do
    task sample: :environment do
      cbf = ScrapCbf.new({ year: 2020, load_from_sample: true })

      ScrapCbfRecord::ActiveRecord.save(cbf.to_h)
    end
  end
end

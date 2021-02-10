# frozen_string_literal: true
class ApplicationWorker
  include Sidekiq::Worker

  Time.zone = 'Brasilia'
end

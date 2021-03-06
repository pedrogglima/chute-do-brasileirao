# frozen_string_literal: true

require 'open-uri'
require 'securerandom'

# TODO, create specs
class Download
  class << self
    def on(url, file_path, filename = nil)
      create_folder_if_not_exist(file_path)

      filename ||= generate_filename

      full_file_path = "#{file_path}/#{filename}"

      download_and_save(url, full_file_path)

      full_file_path
    end

    def on_tmp(url, filename = nil, folder_name = nil)
      file_path = "#{tmp_folder_path}/#{folder_name}"

      on(url, file_path, filename)
    end

    private

    def download_and_save(url, full_file_path)
      url = secure_url_before_open(url)

      IO.copy_stream(url.open, full_file_path)
    end

    def create_folder_if_not_exist(folder_path = nil)
      folder_path ||= tmp_folder_path
      FileUtils.mkdir_p folder_path.to_s
    end

    def secure_url_before_open(url)
      URI.parse(url)
    end

    def tmp_folder_path
      'tmp'
    end

    def generate_filename
      SecureRandom.uuid
    end
  end
end

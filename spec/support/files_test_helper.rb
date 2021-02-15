# frozen_string_literal: true
require "rails_helper"

module FilesTestHelper
  extend self

  def png_name
    'test-image.png'
  end

  def png
    upload(png_name, 'image/png')
  end

  def jpg_name
    'test-image.jpg'
  end

  def jpg
    upload(jpg_name, 'image/jpg')
  end

  def tiff_name
    'test-image.tiff'
  end

  def tiff
    upload(tiff_name, 'image/tiff')
  end

  def pdf_name
    'test-image.pdf'
  end

  def pdf
    upload(pdf_name, 'application/pdf')
  end

  private

  def upload(name, type)
    file_path = Rails.root.join('spec', 'assets', name)
    Rack::Test::UploadedFile.new(file_path, type)
  end
end

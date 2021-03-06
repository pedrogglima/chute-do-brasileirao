# frozen_string_literal: true

require 'rails_helper'

module FilesTestHelper
  extend self

  def png_name
    'test-image.png'
  end

  def pgn_path
    file_path(pgn_name).to_s
  end

  def png
    upload(png_name, 'image/png')
  end

  def jpg_name
    'test-image.jpg'
  end

  def jpg_path
    file_path(jpg_name).to_s
  end

  def jpg
    upload(jpg_name, 'image/jpg')
  end

  def tiff_name
    'test-image.tiff'
  end

  def tiff_path
    file_path(tiff_name).to_s
  end

  def tiff
    upload(tiff_name, 'image/tiff')
  end

  def pdf_name
    'test-image.pdf'
  end

  def pdf_path
    file_path(pdf_name).to_s
  end

  def pdf
    upload(pdf_name, 'application/pdf')
  end

  def team_avatar_name
    'team-avatar.jpg'
  end

  def team_avatar_path
    file_path(team_avatar_name).to_s
  end

  def team_avatar_jpg
    upload(team_avatar_name, 'image/jpg')
  end

  def team_avatar_size
    File.size(team_avatar_path)
  end

  def duplicate(source, destination)
    FileUtils.cp(source, destination)
  end

  private

  def upload(name, type)
    Rack::Test::UploadedFile.new(file_path(name), type)
  end

  def file_path(name)
    Rails.root.join('spec', 'assets', name)
  end
end

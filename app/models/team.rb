# frozen_string_literal: true

class Team < ApplicationRecord
  # associations
  #
  has_many :rankings
  has_many :matches
  has_many :opponents, class_name: 'Match', foreign_key: 'opponent_id'
  has_many :next_opponents,
           class_name: 'Ranking',
           foreign_key: 'next_opponent_id'
  has_one_attached :avatar

  # callbacks
  #
  after_create_commit :upload_avatar

  # validations
  #
  validates :name,
            presence: true,
            uniqueness: true,
            length: { within: 1..100 }

  validates :state,
            presence: true,
            length: { within: 1..2 }

  validates :avatar_url,
            presence: true

  def upload_avatar_from_url
    return unless avatar

    avatar.purge if avatar.attached?

    image_path = Download.on_tmp(avatar_url)

    process_image_before_attach(image_path)

    attach_file(image_path, "avatar_#{name}", 'image/jpg')
  end

  private

  # private methods
  #
  def upload_avatar
    UploadAvatarWorker.perform_async(id)
  end

  def attach_file(image_path, filename, content_type)
    # p.s #remove_br_accents & #fileable are core_exts methods
    # found on initialize/core_extensions/active_support/string/modifiers.rb
    formatted_filename = filename.remove_br_accents.fileable

    avatar.attach(
      io: File.open(image_path),
      filename: formatted_filename.to_s,
      content_type: content_type
    )
  end

  def process_image_before_attach(image_path, save_path = nil)
    save_path ||= image_path

    ImageProcessing::MiniMagick.source(image_path)
                               .resize_to_limit(45, 45)
                               .call(destination: save_path)
  end
end

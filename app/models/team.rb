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
  after_create_commit :upload_avatar_from_url

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

  private

  # private methods
  #
  def upload_avatar_from_url
    UploadAvatarWorker.perform_async(id)
  end
end

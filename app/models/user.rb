# frozen_string_literal: true

class User < ApplicationRecord
  # associations
  #
  has_many :bets

  # validations
  #
  validates :email, uniqueness: true, length: { maximum: 100 }
  validates :first_name, length: { within: 1..100 }
  validates :last_name, length: { maximum: 100 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :rememberable, :recoverable

  devise :database_authenticatable,
         :registerable,
         :validatable,
         :trackable,
         :omniauthable,
         omniauth_providers: %i[twitter google_oauth2]

  # scopes
  #
  def self.from_omniauth(provider:, uid:, email:, name:)
    user = find_or_create_by(email: email) do |new_user|
      new_user.provider = provider
      new_user.uid = uid
      new_user.email = email
      new_user.password = Devise.friendly_token[0, 20]
      new_user.first_name = name
    end

    # If user already exist the find_or_create_by block won't be call
    user.update(provider: provider, uid: uid) unless user.uid == uid

    user
  end

  # public methods
  #
  def full_name
    "#{first_name} #{last_name}".strip
  end
end

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
  # :confirmable, :lockable, :timeoutable, :rememberable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :validatable, :trackable,
         :omniauthable,
         omniauth_providers: %i[twitter]

  # scopes
  #
  # used on reset password functionality
  #
  scope :with_active_reset_password, lambda { |token|
    where('reset_password_sent_at > ?', Time.now - 4 * 3600)
      .find_by!(reset_password_token: token)
  }
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.name
      # user.username = auth.info.nickname
      # user.image = auth.info.image

      # If you are using confirmable and the provider(s) you use validate emails
      # user.skip_confirmation!
    end
  end

  # public methods
  #
  def full_name
    "#{first_name} #{last_name}".strip
  end
end

# frozen_string_literal: true
class User < ApplicationRecord
  # associations
  #
  has_many :bets

  # validations
  #
  validates :email, uniqueness: true, length: { maximum: 100 }
  validates :first_name, length: { within: 1..100 }
  validates :last_name, length: { within: 1..100 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :rememberable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :trackable

  # scopes
  #
  # used on reset password functionality
  #
  scope :with_active_reset_password, lambda { |token|
    where('reset_password_sent_at > ?', Time.now - 4 * 3600)
      .find_by!(reset_password_token: token)
  }
end

# frozen_string_literal: true
class Match < ApplicationRecord
  belongs_to :championship
  belongs_to :round
  belongs_to :team
  belongs_to :opponent, class_name: "Team", foreign_key: "opponent_id"

  validates :identification, presence: true
end

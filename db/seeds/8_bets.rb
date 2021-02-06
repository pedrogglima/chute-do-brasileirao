# frozen_string_literal: true
user = User.first
match_1 = Match.first
match_2 = Match.second

Bet.create!(
  user: user,
  match: match_1,
  score_team: 1,
  score_opponent: 1
)

Bet.create!(
  user: user,
  match: match_2,
  score_team: 1,
  score_opponent: 2
)

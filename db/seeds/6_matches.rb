# frozen_string_literal: true
championship = Championship.find_by(year: 2020)
round = Round.find_by(number: 1)
team_1 = Team.find_by(name: "São Paulo")
team_2 = Team.find_by(name: "Bahia")

Match.create!(
  championship: championship,
  round: round,
  team: team_1,
  opponent: team_2,
  identification: "Jogo: 1"
)

Match.create!(
  championship: championship,
  round: round,
  team: team_2,
  opponent: team_1,
  identification: "Jogo: 2"
)
